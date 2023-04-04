function yearFID = getFIDyear(ExcelFile, caseNum)

ExcelSheet = ExcelFile.Sheets.Item('Projects');

colCase = excelColumnOffset('E', caseNum);

yearFID = ExcelSheet.Range([colCase, '25']).Value;
