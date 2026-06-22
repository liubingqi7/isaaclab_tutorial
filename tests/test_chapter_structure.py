from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]


class ChapterStructureTest(unittest.TestCase):
    def test_ch07_required_files_exist(self):
        required = [
            "chapters/ch07_isaaclab_intro/source_map.md",
            "chapters/ch07_isaaclab_intro/code_index.md",
            "chapters/ch07_isaaclab_intro/run.md",
            "chapters/ch07_isaaclab_intro/tests.md",
            "chapters/ch07_isaaclab_intro/notes.md",
            "evidence/ch07_isaaclab_intro/README.md",
            "tools/remote/check_ch07_isaaclab.sh",
        ]
        missing = [path for path in required if not (ROOT / path).is_file()]
        self.assertEqual(missing, [])

    def test_ch07_maps_book_to_source_and_validation(self):
        source_map = (ROOT / "chapters/ch07_isaaclab_intro/source_map.md").read_text()
        run_doc = (ROOT / "chapters/ch07_isaaclab_intro/run.md").read_text()
        tests_doc = (ROOT / "chapters/ch07_isaaclab_intro/tests.md").read_text()

        for text in (source_map, run_doc, tests_doc):
            self.assertIn("192.168.2.16", text)
            self.assertIn("env_isaaclab_2.3_lbq", text)

        self.assertIn("v2.3.0", source_map)
        self.assertIn("scripts/demos/multi_asset.py", source_map)
        self.assertIn("/home/liubingqi/lbq/isaaclab_tutorial_sources", run_doc)
        self.assertIn("pxr", tests_doc)

    def test_manifest_records_clean_ch07_source(self):
        manifest = (ROOT / "workspace_manifest.yaml").read_text()
        self.assertIn("isaaclab_clean", manifest)
        self.assertIn("/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0", manifest)
        self.assertIn("3c6e67bb5c7ada942a6d1884ab69338f57596f77", manifest)


if __name__ == "__main__":
    unittest.main()
