extends GutTest

const REPO_ROOT := "res://../"
const README_PATH := REPO_ROOT + "README.md"
const PLUGIN_CFG_PATH := REPO_ROOT + "plugin.cfg"
const ADDONS_MANIFEST_PATH := "res://addons.jsonc"
const PROJECT_GODOT_PATH := "res://project.godot"

func _read_text(path: String) -> String:
	var file := FileAccess.open(path, FileAccess.READ)
	assert_not_null(file, "Expected to open %s" % path)
	if file == null:
		return ""
	return file.get_as_text()

func test_readme_marks_xr_as_future_third_wave_scope() -> void:
	var readme := _read_text(README_PATH)
	assert_true(readme.contains("future / third-wave shell path"))
	assert_true(readme.contains("PC-first camera gameplay"))
	assert_true(readme.contains("mobile following later and XR after that"))
	assert_false(readme.contains("bootstrap-state drift"), "README should not normalize stale manifest drift")
	assert_false(readme.contains("transition-era `aerobeat-core`"), "README should not excuse a stale aerobeat-core pin")

func test_plugin_metadata_keeps_xr_future_facing() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load(PLUGIN_CFG_PATH)
	assert_eq(err, OK, "plugin.cfg should load")
	assert_eq(
		cfg.get_value("plugin", "description"),
		"Future/third-wave XR interaction shell and layout manager for AeroBeat's Community Edition VR return path."
	)

func test_manifest_keeps_only_current_xr_shell_dependencies() -> void:
	var manifest := _read_text(ADDONS_MANIFEST_PATH)
	assert_true(manifest.contains('"aerobeat-ui-core"'))
	assert_true(manifest.contains('"aerobeat-ui-kit-community"'))
	assert_true(manifest.contains('"gut"'))
	assert_false(manifest.contains('"aerobeat-core"'))

func test_project_name_stays_future_workbench_truth() -> void:
	var project_text := _read_text(PROJECT_GODOT_PATH)
	assert_true(project_text.contains('config/name="AeroBeat UI Shell XR Future Workbench"'))
