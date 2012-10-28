describe "Currency model" do
  describe "archiver" do
    before do
      @currency = Currency.new('USD', 'US Dollar', 12.23)
      @docs = [ @currency ]
      @path = "#{App.documents_path}/files.plist"
      NSKeyedArchiver.archiveRootObject(@docs, toFile: @path) 
    end

    it "save" do
      App.documents_path.should.not.be.nil
    end

    it "should retrieve" do
      results = NSKeyedUnarchiver.unarchiveObjectWithFile(@path)
      results.length.should == 1
      results[0].name.should == "US Dollar"
    end
  end
end
