class CurrencyController < PullRefreshTableViewController

  def viewDidLoad
    super
    self.view.dataSource = self.view.delegate = self
    @results = CurrencyQuerier.current || []
  end

  def refresh
    CurrencyQuerier.latest do | r | 
      @results = r
      self.stopLoading
      self.view.reloadData
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @results.length
  end


  CellID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    currency = @results[indexPath.row]
    cell.textLabel.text = "#{currency.name} (#{currency.code})"
    cell.detailTextLabel.text = "#{currency.rate}"
    cell
  end
end
