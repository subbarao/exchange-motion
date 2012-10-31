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
    searchbar.accessibilityLabel = "Search"

    view.addSubview(searchbar)
    tableView.tableHeaderView = searchbar
  end

  def searchBarSearchButtonClicked(searchBar)
    @results = @filter.search(searchBar.text)
    searchBar.setShowsCancelButton(true, animated:true)
    view.reloadData
  end

  def searchBarCancelButtonClicked(searchBar)
    @results = @filter.search
    searchBar.text = nil
    searchBar.setShowsCancelButton(false, animated:true)
    view.reloadData
  end

  def refresh
    CurrencyQuerier.latest do | currencies | 
      initialize_currencies(currencies)
      CurrencyQuerier.archive(currencies)
      stopLoading
      view.reloadData
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @results.length
  end

  CellID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    unless cell = tableView.dequeueReusableCellWithIdentifier(CellID)
      cell =  UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    end

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
