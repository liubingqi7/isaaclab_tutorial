from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]


class ChapterStructureTest(unittest.TestCase):
    def test_reader_markdown_is_index_and_one_file_per_chapter(self):
        markdown_files = sorted(path.relative_to(ROOT).as_posix() for path in ROOT.rglob("*.md"))
        self.assertEqual(markdown_files, ["README.md", "chapters/ch07_isaaclab_intro.md"])

    def test_readme_links_to_ch07(self):
        readme = (ROOT / "README.md").read_text()
        self.assertIn("[第 7 章](chapters/ch07_isaaclab_intro.md)", readme)
        self.assertIn("tools/remote/check_ch07_isaaclab.sh", readme)

    def test_ch07_maps_book_to_source_and_validation(self):
        chapter = (ROOT / "chapters/ch07_isaaclab_intro.md").read_text()

        self.assertIn("192.168.2.16", chapter)
        self.assertIn("env_isaaclab_2.3_lbq", chapter)
        self.assertIn("v2.3.0", chapter)
        self.assertIn("3c6e67bb5c7ada942a6d1884ab69338f57596f77", chapter)
        self.assertIn("scripts/demos/multi_asset.py", chapter)
        self.assertIn("/home/liubingqi/lbq/isaaclab_tutorial_sources", chapter)
        self.assertIn("pxr", chapter)

        for heading in ["## 代码来源", "## 书中对应", "## 代码结构", "## 运行与测试"]:
            self.assertIn(heading, chapter)

    def test_manifest_records_clean_ch07_source(self):
        manifest = (ROOT / "workspace_manifest.yaml").read_text()
        self.assertIn("isaaclab_clean", manifest)
        self.assertIn("/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0", manifest)
        self.assertIn("3c6e67bb5c7ada942a6d1884ab69338f57596f77", manifest)


if __name__ == "__main__":
    unittest.main()
