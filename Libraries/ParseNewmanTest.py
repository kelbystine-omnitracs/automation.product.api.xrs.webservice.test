from bs4 import BeautifulSoup
import xlwt
from xlwt import Workbook
import re
import csv

class ParseNewmanTest:

    __version__ = '0.1'

    def _create_soup(self, file_path):
        contents = open(file_path, "r")
        soup = BeautifulSoup(contents, 'html.parser')
        return soup
            
    def get_test_results(self, file_path):
        more_soup = self._create_soup(file_path)
        results_list = []
        soup_object_list = more_soup.find_all('div', id=re.compile('^folder-'))
        for soup_object in soup_object_list:
            test_name = self._get_test_name(soup_object)
            case_id = self._get_testcase_id(soup_object)
            pass_percentage = self._get_pass_percentage(soup_object)
            result_list = [test_name, case_id, pass_percentage]
            results_list.append(result_list)
        return results_list

    def create_excel_file(self, text_list1):
        wb = Workbook()
        sheet1 = wb.add_sheet('Sheet 1', cell_overwrite_ok=True)
        for text in text_list1:
            sheet1.write(text_list1.index(text), 0, text)
        wb.save('xlwt_example.xls')

    def create_text_file(self, text_list, file_name):
        file = open(file_name,"a")
        for text in text_list:
            file.write(text + "\n")
        file.close()

    def create_csv_file(self, text_list, file_name):
        with open(file_name, mode='w', newline='') as test_results:
            results_writer = csv.writer(test_results, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            row = ['Test Case', 'Test Case ID', 'Pass Percentage']
            results_writer.writerow(row) 
            results_writer.writerows(text_list)    
    
    def _get_test_name(self, soup_object):
        test_name_object = soup_object.find('a', id=re.compile('^requests-'))
        test_name = 'Test Name Not Found' if test_name_object is None else test_name_object.get_text(strip=True)
        return test_name


    def _get_testcase_id(self, soup_object):
        case_id_object = soup_object.find('code', id='description')
        process = lambda x: " ".join(x.split())
        case_id = 'Case Id Not Found' if case_id_object is None else process(case_id_object.get_text(strip=True))
        return case_id

    def _get_pass_percentage(self, soup_object):
        pass_percentage_object = soup_object.find(class_='progress-bar').strong.contents
        pass_percentage = 'No Pass Percentage Found' if pass_percentage_object is None else pass_percentage_object[0]
        return pass_percentage