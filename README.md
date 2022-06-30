# PEARS Monthly Data Cleaning

The PEARS Monthly Data Cleaning script flags records based on guidance provided to [PEARS](https://www.k-state.edu/oeie/pears/) users by the Illinois [SNAP-Ed](https://www.fns.usda.gov/snap/snap-ed) implementating agency. Users are notified via email how to update their flagged records.

PEARS guidance for [Illinois Nutrition Education Programs \(INEP\)](https://inep.extension.illinois.edu/) is located in the [/il_pears_guidance]() directory. Illinois SNAP-Ed programming is delivered through three methods:
1. [Direct Education]() - which is tracked using the Program Activities module in PEARS\.
2. [Indirect Education]() - which is tracked using the Indirect Activities module in PEARS\.
3. [Policy, System, and Environment]() - which utilizes the Coalitions, Partnerships, PSE Site Activities, and Program Activities PEARS modules for reporting\.

## Input Files

The following input files are required to run the PEARS Monthly Data Cleaning script:
- [BABY_NAMES_IL.TXT](): A csv of Illinois baby names from 1910-2020, obtained from the [Social Security Administration](https://www.ssa.gov/oact/babynames/state/)\.
- [FY22_INEP_Staff_List.xlsx](): A workbook that compiles various lists of INEP staff\.
- [Illinois Extension Unit Counties.xlsx](): A workbook that maps Illinois counties to Illinois Extension units\.
- [Update Notifications.xlsx](): A workbook that compiles the update notifications used in the PEARS Monthly Data Cleaning\.
- Reformatted PEARS module exports output from the [PEARS Nightly Export Reformatting script](https://github.com/jstadni2/pears_nightly_export_reformatting):
	- [Coalition_Export.xlsx]()
	- [Indirect_Activity_Export.xlsx]()
	- [Partnership_Export.xlsx]()
	- [Program_Activities_Export.xlsx]()
	- [PSE_Site_Activity_Export.xlsx]()
	- [User_Export.xlsx]()

Example input files are provided in the [/example_inputs]() directory. 

## Output Files

The following output files are produced by the PEARS Monthly Data Cleaning script:
- [Former Staff PEARS Updates YYYY-MM.xlsx](): A workbook that compiles the outstanding updates of former INEP staff for each module\.
- [Monthly PEARS Corrections YYYY-MM.xlsx](): A workbook that summarizes the PEARS updates for the given month and compiles updates for each module\.

Example output files are provided in the [/example_outputs]() directory.
