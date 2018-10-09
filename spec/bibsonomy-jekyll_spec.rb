require "spec_helper"

RSpec.describe "BibSonomy" do
  let(:site) { make_site }
  before { site.process }

  context "full page rendering" do
    let(:content) { File.read(dest_dir("page.html")) }

    it "renders list item" do
      expect(content).to match(%r!<li class="paper-conference">!)
    end

    it "renders link" do
      expect(content).to match(%r!<a href="https://www.bibsonomy.org/publication/893978f4a3ac2c5556e391b8749ed8c0/bibsonomy-ruby">BibSonomy</a>!)
    end
  end

  context "variable expansion" do
    let(:content) { File.read(dest_dir("page_variable_expansion.html")) }

    it "renders list item" do
      expect(content).to match(%r!<li class="paper-conference">!)
    end

    it "renders link" do
      expect(content).to match(%r!<a href="https://www.bibsonomy.org/publication/893978f4a3ac2c5556e391b8749ed8c0/bibsonomy-ruby">BibSonomy</a>!)
    end
  end

end
