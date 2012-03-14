require 'writes_anki_import_file'

describe WritesAnkiImportFile do
  subject { described_class.new }

  describe "#write_to" do
    it "adds one Anki fact to the specified file" do
      File.should_receive(:open).with("foo_bar.txt", "a")
      subject.write_to("foo_bar.txt")
    end

  end
end

