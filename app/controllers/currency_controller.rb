class CurrencyController < UIViewController
  def viewDidLoad
    super
    initRefreshButton
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
    @results = CurrencyQuerier.latest
  end
end
