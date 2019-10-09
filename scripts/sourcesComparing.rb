require 'xcodeproj'

def compare_targets_sources(project_path, compared_targets)
	project = Xcodeproj::Project.open(project_path)
	whitelist_sources = read_whitelist_sources()
	if !whitelist_sources.empty?
		puts "🙈 There are files that will not be scanned:"
		puts whitelist_sources
	end

	compile_sources_files = targets_compile_sources_files(project, compared_targets)
	compile_sources_is_valid, invalid_sources = compare_files(project, compile_sources_files, whitelist_sources)
	if compile_sources_is_valid
		puts "🦄 All fine with compile sources..."
	else
		puts "🐴 🐴 There are some problems with compile sources:"
		puts invalid_sources
	end

	bundle_resources_files = targets_bundle_resources_files(project, compared_targets)
	bundle_resources_is_valid, invalid_resources = compare_files(project, bundle_resources_files, whitelist_sources)
	if bundle_resources_is_valid
		puts "🦄 All fine with bundle resources..."
	else
		puts "🐴 🐴 There are some problems with bundle resources:"
		puts invalid_resources
	end

	frameworks_files = targets_frameworks(project, compared_targets)
	frameworks_is_valid, invalid_frameworks = compare_frameworks(project, frameworks_files, whitelist_sources)
	if frameworks_is_valid
		puts "🦄 All fine with frameworks..."
	else
		puts "🐴 🐴 There are some problems with frameworks:"
		puts invalid_frameworks
	end

	success_check = compile_sources_is_valid && bundle_resources_is_valid && frameworks_is_valid
	if success_check
		puts "🌴 Success: Verification completed successfully!"
	else
		puts "🛑 Error: Not all files were correctly attached to the project."
		raise "Inconsistent project error"
	end
end

def targets_compile_sources_files(project, compared_targets)
	targets = project.targets
	targets_files = Array.new
	targets.each do |target|
		if !compared_targets.include? target.to_s
			next
		end
		targets_files.push target.source_build_phase.files
	end
	return targets_files
end

def targets_bundle_resources_files(project, compared_targets)
	targets = project.targets
	targets_files = Array.new
	targets.each do |target|
		if !compared_targets.include? target.to_s
			next
		end
		targets_files.push target.resources_build_phase.files
	end
	return targets_files
end

def targets_frameworks(project, compared_targets)
	targets = project.targets
	frameworks = Array.new
	targets.each do |target|
		if !compared_targets.include? target.to_s
			next
		end
		frameworks.push target.frameworks_build_phase.files
	end
	return frameworks
end


def compare_files(project, targets_files, whitelist)
	problem_files_paths = Array.new
	targets_files.each do |files|
		targets_files.each do |compared_files|
			if compared_files == files
				next
			end
			files_paths = files.map { |file| file.file_ref.hierarchy_path.to_s }
			compared_files_paths = compared_files.map { |file| file.file_ref.hierarchy_path.to_s }
			paths = files_paths - compared_files_paths | compared_files_paths - files_paths
			problem_files_paths.push paths
		end
	end

	result_problem_files = problem_files_paths.flatten.uniq.select { |file| !whitelist.include? file }
	if result_problem_files.empty?
		return true, []
	else
		return false, result_problem_files
	end
end

def compare_frameworks(project, frameworks_files, whitelist)
	problem_frameworks_names = Array.new
	frameworks_files.each do |frameworks|
		frameworks_files.each do |compared_frameworks|
			if compared_frameworks == frameworks
				next
			end
			frameworks_names = frameworks.map { |framework| framework.file_ref.display_name }
			compared_frameworks_names = compared_frameworks.map { |framework| framework.file_ref.display_name }
			names = frameworks_names - compared_frameworks_names | compared_frameworks_names - frameworks_names
			problem_frameworks_names.push names
		end
	end

	result_problem_frameworks = problem_frameworks_names.flatten.uniq.select { |file| !whitelist.include? file }
	if result_problem_frameworks.empty?
		return true, []
	else
		return false, result_problem_frameworks
	end
end

def read_whitelist_sources()
	whitelist_path = File.join(__dir__, 'sourceComparingWhitelist.txt')
	return File.read(whitelist_path).split
end

if ARGV.count >= 3
	project_path = ARGV[0]
	targets = ARGV.drop(1)
	compare_targets_sources(project_path, targets)
else
    puts "🛑 Error: invalid arguments"
    raise "Invalid arguments error"
end