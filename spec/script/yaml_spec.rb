require "rspec/helper"
describe "script/yml" do
  let(:file) { File.expand_path("../../fixture/test.yml", __FILE__) }
  let(:data) do
    YAML.load_file(
      file
    )
  end

  before :each, :yaml => :update do
    FileUtils.rm_f(file); File.open(file, "w+") do |f|
      f.puts "---"
      f.puts "key1: []"
      f.puts "key2:"
      f.puts "  keya: vala"
      f.puts "key3:"
      f.close
    end
  end

  after :each, :yaml => :update do
    FileUtils.rm_f(file)
  end

  def yaml_update(*cmd)
    run File.expand_path("../../../script/yaml", __FILE__), "update", \
      "-f", file, *cmd
  end

  def yaml(*cmd)
    run File.expand_path("../../../script/yaml", __FILE__), "-f", \
      file, *cmd
  end

  specify "-k key5 -> [keya, keyb, keyc] (0)" do
    result = yaml "-k", :key5
    expect(result[:stdout].strip).to eq \
      "keya keyb keyc"
  end

  specify "key5 -> [keya=vala keyb=valb keyc=valc]" do
    result = yaml :key5
    expect(result[:stdout].strip).to eq \
      "keya=vala\nkeyb=valb\nkeyc=valc"
  end

  specify "-> [] (0)" do
    result = yaml
    expect(result[:stdout]).to be_empty
    expect(result[:status]).to eq 0
  end

  specify "key1 -> [val1] (0)" do
    result = yaml :key1
    expect(result[:stdout].strip).to eq "val1"
    expect(result[:status]).to eq 0
  end

  specify "key1. -> [] (0)" do
    result = yaml "key1."
    expect(result[:stdout].strip).to be_empty
    expect(result[:status]).to eq 0
  end

  specify "fake1 -> [] (0)" do
    result = yaml :fake1
    expect(result[:stdout]).to be_empty
    expect(result[:status]).to eq 0
  end

  specify "fak1.fak2.fak3 -> [] (0)" do
    result = yaml "fak1.fak2.fak3"
    expect(result[:stdout]).to be_empty
    expect(result[:status]).to eq 0
  end

  context "-V" do
    specify "key1.val1 -> val1 key1 -> (0)" do
      result = yaml "-V", "key1.val1"
      expect(result[:status]).to eq 0
    end
  end

  context "value is an array" do
    specify "key4 -kV fak4 -> (1)" do
      result = yaml :key4, "-kV", :fak4
      expect(result[:status]).to eq 1
    end

    specify "key4 -kV val4 -> (0)" do
      result = yaml :key4, "-kV", :val4
      expect(result[:status]).to eq 0
    end
  end

  specify "key1 -V fak1 -> (1)" do
    result = yaml :key1, "-V", :fak1
    expect(result[:status]).to eq 1
  end

  specify "key1. -V val1. -> (1)" do
    result = yaml "key1.", "-V", "val1."
    expect(result[:status]).to eq 1
  end

  specify "key1 -V val1 -> (0)" do
    result = yaml :key1, "-V", :val1
    expect(result[:status]).to eq 0
  end

  specify "-V key1 -> (0)" do
    result = yaml "-V", :key1
    expect(result[:status]).to eq 0
  end

  specify "key3.keya -V vala -> (0)" do
    result = yaml "key3.keya", "-V", :vala
    expect(result[:status]).to eq 0
  end

  specify "key3 -kV keya -> (0)" do
    result = yaml :key3, "-kV", :keya
    expect(result[:status]).to eq 0
  end

  describe "update", :yaml => :update do
    let(:file) do
      File.expand_path(
        "../../fixture/temp.yml", __FILE__
      )
    end

    it "pushes onto an array" do
      result = yaml_update :key1, :val1, :val2
      expect(result[:status]).to eq 0
      expect(data["key1"]).to eq [
        "val1", "val2"
      ]
    end

    it "overwrites normal values" do
      result = yaml_update "key2.keya", "hello"
      expect(data["key2"]["keya"]).to eq "hello"
      expect(result[:status]).to eq 0
    end
  end
end
