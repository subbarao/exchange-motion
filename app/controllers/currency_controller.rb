class CurrencyController < PullRefreshTableViewController

  def viewDidLoad
    super
    initialize_currencies CurrencyQuerier.current
    view.dataSource = view.delegate = self
    add_search_bar
  end

  def add_search_bar
    searchbar = UISearchBar.alloc.initWithFrame(CGRectMake(33, 33, 264, 31))
    searchbar.delegate = self
    searchbar.accessibilityLabel = "Refresh!"

    view.addSubview(searchbar)
    tableView.tableHeaderView = searchbar
  end

  def searchBarSearchButtonClicked(searchBar)
    @results = @filter.search(searchBar.text)

    self.view.reloadData
    searchBar.setShowsCancelButton(true, animated:true)
  end

  def refresh
    CurrencyQuerier.latest do | r | 
      initialize_currencies r
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

  def initialize_currencies(currencies)
    @filter = CurrencyFilter.new(currencies)
    @results = @filter.search
  end
end
