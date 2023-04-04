function applyMarketSizeChange(ExcelFile, marketSize)

    ExcelSheet = ExcelFile.Sheets.Item('Market');
    
    ExcelSheet.Range('J17').Value = marketSize;

end