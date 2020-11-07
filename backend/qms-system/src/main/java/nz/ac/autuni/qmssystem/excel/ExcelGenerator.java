package nz.ac.autuni.qmssystem.excel;

import nz.ac.autuni.qmssystem.model.FMEATable;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 7/11/20 1:30 pm
 */
public class ExcelGenerator {

    public static ByteArrayInputStream customersToExcel(List<FMEATable> tables) throws IOException {

        try (
                Workbook workbook = new XSSFWorkbook();
                ByteArrayOutputStream out = new ByteArrayOutputStream();
        ) {

            Sheet sheet = workbook.createSheet("FMEATable");
            sheet.setDefaultColumnWidth(40);

            // create style for header cells
            CellStyle style = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setFontName("Arial");

            style.setFillForegroundColor(HSSFColor.HSSFColorPredefined.BLUE.getIndex());
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            font.setBold(true);
            font.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
            style.setFont(font);

            // Row for Header
            Row header = sheet.createRow(0);

            header.createCell(0).setCellValue("Hazard Class");
            header.getCell(0).setCellStyle(style);
            header.createCell(1).setCellValue("Source Id");
            header.getCell(1).setCellStyle(style);
            header.createCell(2).setCellValue("Foreseeable Sequence of Events");
            header.getCell(2).setCellStyle(style);
            header.createCell(3).setCellValue("Hazardous Situation");
            header.getCell(3).setCellStyle(style);
            header.createCell(4).setCellValue("Harm");
            header.getCell(4).setCellStyle(style);
            header.createCell(5).setCellValue("Severity of Harm");
            header.getCell(5).setCellStyle(style);
            header.createCell(6).setCellValue("Probability");
            header.getCell(6).setCellStyle(style);
            header.createCell(7).setCellValue("Risk Priority");
            header.getCell(7).setCellStyle(style);
            header.createCell(8).setCellValue("Recommending Action");
            header.getCell(8).setCellStyle(style);
            header.createCell(9).setCellValue("Type of Action");
            header.getCell(9).setCellStyle(style);
            header.createCell(10).setCellValue("Action Done");
            header.getCell(10).setCellStyle(style);
            header.createCell(11).setCellValue("Severity Of Harm 2");
            header.getCell(11).setCellStyle(style);
            header.createCell(12).setCellValue("Probability 2");
            header.getCell(12).setCellStyle(style);
            header.createCell(13).setCellValue("Residual Risk");
            header.getCell(13).setCellStyle(style);

            int rowCount = 1;

            for (FMEATable table : tables) {
                Row userRow = sheet.createRow(rowCount++);
                userRow.createCell(0).setCellValue(table.getHazardClass());
                userRow.createCell(1).setCellValue(table.getSourceId());
                userRow.createCell(2).setCellValue(table.getForeseeableSequenceOfEvents());
                userRow.createCell(3).setCellValue(table.getHazardousSituation());
                userRow.createCell(4).setCellValue(table.getHarm());
                userRow.createCell(5).setCellValue(table.getSeverityOfHarm());
                userRow.createCell(6).setCellValue(table.getProbability());
                userRow.createCell(7).setCellValue(table.getRiskPriority());
                userRow.createCell(8).setCellValue(table.getRecommendingAction());
                userRow.createCell(9).setCellValue(table.getTypeOfAction());
                userRow.createCell(10).setCellValue(table.getActionDone());
                userRow.createCell(11).setCellValue(table.getSeverityOfHarm2());
                userRow.createCell(12).setCellValue(table.getProbability2());
                userRow.createCell(13).setCellValue(table.getResidualRisk());
            }
            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }
}
