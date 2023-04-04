function [yearFID, yearCOD] = getFIDyear(ExcelFile, caseNum)

ExcelSheet = ExcelFile.Sheets.Item('Projects');

colCase = excelColumnOffset('E', caseNum);
    
yearFID = ExcelSheet.Range([colCase, '27']).Value;

yearCOD = ExcelSheet.Range([colCase, '28']).Value;
