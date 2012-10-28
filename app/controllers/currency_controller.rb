class CurrencyController < UITableViewController

  def viewDidLoad
    super
    initRefreshButton
    self.view.dataSource = self.view.delegate = self
    @results = CurrencyQuerier.current || []
    #refreshInfo
  end

  def initRefreshButton
    toolBar = UIToolbar.alloc.initWithFrame(CGRectMake(0, 0 , 320 , 40))

    barButton = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, 
                                                                  target:self, 
                                                                  action:'refreshInfo')
    barButton.accessibilityLabel = "Refresh"

    toolBar.setItems([barButton],animated:false)

    self.view.addSubview(toolBar)
  end

  def refreshInfo
    CurrencyQuerier.latest do | r | 
      @results = r
      self.tableView.reloadData
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
