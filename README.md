# PEARS Monthly Data Cleaning

The PEARS Monthly Data Cleaning script flags records based on guidance provided to [PEARS](https://www.k-state.edu/oeie/pears/) users by the Illinois [SNAP-Ed](https://www.fns.usda.gov/snap/snap-ed) implementating agency. Users are notified via email how to update their flagged records.

PEARS guidance for [Illinois Nutrition Education Programs \(INEP\)](https://inep.extension.illinois.edu/) is located in the [/il_pears_guidance](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/il_pears_guidance) directory. Illinois SNAP-Ed programming is delivered through three methods:
1. [Direct Education](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/il_pears_guidance/direct_education) - which is tracked using the Program Activities module in PEARS\.
2. [Indirect Education](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/il_pears_guidance/indirect_education) - which is tracked using the Indirect Activities module in PEARS\.
3. [Policy, System, and Environment](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/il_pears_guidance/policy_system_and_environment) - which utilizes the Coalitions, Partnerships, PSE Site Activities, and Program Activities PEARS modules for reporting\.

## Installation

The recommended way to install the PEARS Monthly Data Cleaning script is through git, which can be downloaded [here](https://git-scm.com/downloads). Once downloaded, run the following command:

```bash
git clone https://github.com/jstadni2/pears_monthly_data_cleaning
```

Alternatively, this repository can be downloaded as a zip file via this link:
[https://github.com/jstadni2/pears_monthly_data_cleaning/zipball/master/](https://github.com/jstadni2/pears_monthly_data_cleaning/zipball/master/)

This repository is designed to run out of the box on a Windows PC using Docker and the [/example_inputs](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/example_inputs) and [/example_outputs](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/example_outputs) directories.
To run the script in its current configuration, follow [this link](https://docs.docker.com/desktop/windows/install/) to install Docker Desktop for Windows. 

With Docker Desktop installed, this script can be run simply by double clicking the `run_script.bat` file in your local directory.

The `run_script.bat` file can also be run in Command Prompt by entering the following command with the appropriate path:

```bash
C:\path\to\pears_monthly_data_cleaning\run_script.bat
```

### Setup instructions for SNAP-Ed implementing agencies

The following steps are required to execute the PEARS Monthly Data Cleaning script using your organization's PEARS data:
1. Contact [PEARS support](mailto:support@pears.io) to set up an [AWS S3](https://aws.amazon.com/s3/) bucket to store automated PEARS exports.
2. Download the automated PEARS exports. Illinois Extension's method for downloading exports from the S3 is detailed in the [PEARS Nightly Export Reformatting script](https://github.com/jstadni2/pears_nightly_export_reformatting/blob/6f370389776fb8f88495fbe4e7918c203fd84997/pears_nightly_export_reformatting.py#L9-L45).
3. Set the appropriate input and output paths in `pears_monthly_data_cleaning.py` and `run_script.bat`.
	- The [Input Files](#input-files) and [Output Files](#output-files) sections provide an overview of required and output data files.
	- Copying input files to the build context would enable continued use of Docker and `run_script.bat` with minimal modifications.
	- `pears_monthly_data_cleaning.py` may require additional alterations depending on the staff list format. 
4. Set the usename and password variables in [pears_monthly_data_cleaning.py](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/pears_monthly_data_cleaning.py#L764-L765) using valid Office 365 credentials.	

### Additional setup considerations

- The formatting of PEARS export workbooks changes periodically. The example PEARS exports included in the [/example_inputs](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/example_inputs) directory are based on workbooks downloaded on 08/12/22.
Modifications to `pears_monthly_data_cleaning.py` may be necessary to run with subsequent PEARS exports.
- Illinois Extension utilized [Task Scheduler](https://docs.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page) to run this script from a Windows PC on a monthly basis.
- Plans to deploy the PEARS Monthly Data Cleaning script on AWS were never implemented and are currently beyond the scope of this repository.
- Other SNAP-Ed implementing agencies intending to utilize the PEARS Monthly Data Cleaning script should consider the following adjustments as they pertain to their organization:
	- If your organization actively maintains its SNAP-Ed staff list internally in PEARS, the `User_Export.xlsx` workbook could be used in lieu of external staff lists.
	- The conditions for update notifications were defined using [Illinois SNAP-Ed PEARS guidance](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/il_pears_guidance). Adjust as needed for your organization's specification.
	- The [Illinois Baby Names](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/BABY_NAMES_IL.TXT) csv is used to flag Coalition Members with individual's names in the `member_name` field.
	It may be possible to download a similar list for your state from the [Social Security Administration website](https://www.ssa.gov/oact/babynames/state/).
	- The `send_mail()` function in [pears_monthly_data_cleaning.py](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/pears_monthly_data_cleaning.py#L833) is defined using Office 365 as the host.
	Change the host to the appropriate email service provider if necessary.
	- Update notification email templates include a cloud storage link to Illinois SNAP-Ed PEARS guidance or "cheat sheets."
	Lines [787](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/pears_monthly_data_cleaning.py#L787) and
	[985](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/pears_monthly_data_cleaning.py#L985) should be updated to applicable links for your organization.
	- The [Illinois Extension Unit Counties workbook](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Illinois%20Extension%20Unit%20Counties.xlsx)
	maps counties entered in each module's `unit` field to extension units. The `unit` value is used in [lines 894-914](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/pears_monthly_data_cleaning.py#L894-L914)
	to append Regional Specialist contact info to update notification emails. This functionality is subject to your organization's structure and guidance for the `unit` field, and may be omitted from your implementation if necessary. 
	
	
## Input Files

The following input files are required to run the PEARS Monthly Data Cleaning script:
- [BABY_NAMES_IL.TXT](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/BABY_NAMES_IL.TXT): A csv of Illinois baby names from 1910-2020, obtained from the [Social Security Administration](https://www.ssa.gov/oact/babynames/state/).
- [FY22_INEP_Staff_List.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/FY22_INEP_Staff_List.xlsx): A workbook that compiles various lists of INEP staff\.
- [Illinois Extension Unit Counties.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Illinois%20Extension%20Unit%20Counties.xlsx): A workbook that maps Illinois counties to Illinois Extension units\.
- [Update Notifications.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Update%20Notifications.xlsx): A workbook that compiles the update notifications used in the PEARS Monthly Data Cleaning\.
- Reformatted PEARS module exports output from the [PEARS Nightly Export Reformatting script](https://github.com/jstadni2/pears_nightly_export_reformatting):
	- [Coalition_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Coalition_Export.xlsx)
	- [Indirect_Activity_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Indirect_Activity_Export.xlsx)
	- [Partnership_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Partnership_Export.xlsx)
	- [Program_Activities_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/Program_Activities_Export.xlsx)
	- [PSE_Site_Activity_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/PSE_Site_Activity_Export.xlsx)
	- [User_Export.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_inputs/User_Export.xlsx)

Example input files are provided in the [/example_inputs](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/example_inputs) directory.
PEARS module exports included as example files are generated using the [Faker](https://faker.readthedocs.io/en/master/) Python package and do not represent actual program evaluation data. 

## Output Files

The following output files are produced by the PEARS Monthly Data Cleaning script:
- [Former Staff PEARS Updates YYYY-MM.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_outputs/Former%20Staff%20PEARS%20Updates%202022-05.xlsx): A workbook that compiles the outstanding updates of former INEP staff for each module\.
- [Monthly PEARS Corrections YYYY-MM.xlsx](https://github.com/jstadni2/pears_monthly_data_cleaning/blob/master/example_outputs/Monthly%20PEARS%20Corrections%202022-05.xlsx): A workbook that summarizes the PEARS updates for the given month and compiles updates for each module\.

Example output files are provided in the [/example_outputs](https://github.com/jstadni2/pears_monthly_data_cleaning/tree/master/example_outputs) directory.
