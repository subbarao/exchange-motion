class CurrencyQuerier
  @@default_path = 'currencies.plist'

  def self.current(current_path = nil)
    NSLog(path)
    
    NSKeyedUnarchiver.unarchiveObjectWithFile(current_path || path)
  end

  def self.latest(client = OpenExchangeClient, builder = CurrencyFactory, &blk)
    client.latest { | r | blk.call(builder.build(r))  }
  end

  private

  def self.path(path = @@default_path)
    "#{App.documents_path}/#{path}"
  end

  def self.save(objects)
    NSKeyedArchiver.archiveRootObject(objects, toFile: path) 
  end
end
