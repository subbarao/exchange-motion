class CurrencyController < PullRefreshTableViewController

  def viewDidLoad
    super
    @all_results = @results = CurrencyQuerier.current || []
    self.view.dataSource = self.view.delegate = self
    searchbar = UISearchBar.alloc.initWithFrame(CGRectMake(33, 33, 264, 31))
    searchbar.delegate = self
    self.view.addSubview(searchbar)
    self.tableView.tableHeaderView = searchbar
  end

  def searchBarSearchButtonClicked(searchBar)
    regex = Regexp.new(searchBar.text, /i/)
    @results = @all_results.select {|r| regex.match(r.name) }
    self.view.reloadData
    searchBar.setShowsCancelButton(true, animated:true)
  end

  def refresh
    CurrencyQuerier.latest do | r | 
      @all_results = @results = r
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
