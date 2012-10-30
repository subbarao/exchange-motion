class CurrencyQuerier
  @@default_path = 'currencies.plist'

  def self.current(filename = 'currencies.plist')
    NSKeyedUnarchiver.unarchiveObjectWithFile(local_path(filename))
  end

  def self.latest(client = OpenExchangeClient, builder = CurrencyFactory, &blk)
    client.latest { | r | blk.call(builder.build(r))  }
  end

  def self.archive(currencies, filename = 'currencies.plist')
    NSKeyedArchiver.archiveRootObject(currencies, toFile: local_path(filename)) 
  end

  private

    def self.local_path(filename)
      "#{App.documents_path}/#{filename}"
    end
end
