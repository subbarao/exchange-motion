describe "Application 'motion-template'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

  it "should archive" do
    array = %w(a b c)
    path = "#{App.documents_path}/test.plist" 
    array.writeToFile(path, atomically: true)

    result = NSMutableArray.arrayWithContentsOfFile(path)

    result.should == array
  end
end
