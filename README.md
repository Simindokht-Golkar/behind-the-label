# Behind the Label
**Hazardous chemicals in cosmetics: US reports vs. EU rules, and which ingredients really work for which skin.**

🎓 *Final project for the WBS Coding School Data Analytics & AI programme (November 2026).*

## Question
Which hazardous chemicals do cosmetics companies report and remove, how does that compare with EU rules,
and can ingredient chemistry explain which products work for which skin?

## Dashboards (Tableau Public)
- [Safety: California reports vs. the EU ban list](https://public.tableau.com/app/profile/simindokht.gol.kar/viz/behindthelabelwithdashboards/Safety)
- [Skin type: Sephora ratings by skin type](https://public.tableau.com/app/profile/simindokht.gol.kar/viz/behindthelabelwithdashboards/Skintype)

![Removal rate of EU-banned and other chemicals](images/11_h1_removal_share.png)

## Data
| Source | Content | Licence |
|---|---|---|
| [California Safe Cosmetics Program (CDPH)](https://data.ca.gov/dataset/chemicals-in-cosmetics) | Hazardous chemicals reported in ~37,000 cosmetic products, 2009–2020 | CC BY |
| EU CosIng annexes II–VI and ingredient inventory (content: European Commission). Copy used: [nad949/CosIng on Hugging Face](https://huggingface.co/datasets/nad949/CosIng) | Banned/restricted substances (Annexes II–VI) and ingredient functions | EU public data; the copy states no licence |
| [Sephora Products and Skincare Reviews](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews) (Nady Inky, Kaggle) | 8,494 products, 1.1 million skincare reviews | CC BY 4.0 |

Raw data is not stored in this repository; download it from the links above into `data/raw/`.

## Tools and environment
| Tool | Version |
|---|---|
| Python (Anaconda environment `behind_the_label`) | 3.14.10 |
| pandas | 3.1.0 |
| NumPy | 2.5.4 |
| SciPy | 1.18.1 |
| matplotlib | 3.11.2 |
| seaborn | 0.13.2 |
| SQLAlchemy + PyMySQL | 2.0.52 + 1.2.0 |
| python-dotenv | 1.2.2 |
| JupyterLab | 4.6.4 |
| MySQL Server | 8.0.46 |
| Tableau Public | desktop app, 2026 |

The full list of packages is in [`environment.yml`](environment.yml). It was exported on Windows; on macOS or Linux, install the packages from the table above instead.

## How to run
1. Create the environment: `conda env create -f environment.yml`, then `conda activate behind_the_label`.
2. Install MySQL 8, create a file `.env` in the main folder with one line `CON_STRING=mysql+pymysql://USER:PASSWORD@localhost:3306/behind_the_label` (the file is listed in `.gitignore`).
3. Download the raw data (links above) into `data/raw/california/`, `data/raw/cosing/` and `data/raw/sephora/`. Also create the empty folders `data/clean/` and `data/tableau/`.
4. Run the notebooks in this order: **00, 01, 02, 04, 03, 05, 06, 07, 08**. Notebook 04 loads the database that notebook 03 needs for the ingredient matching.

## Progress
- [x] Raw data checked (`notebook/00_check_files.ipynb`)
- [x] California data cleaned (`notebook/01_clean_california.ipynb`)
- [x] EU CosIng data cleaned and matched to California (`notebook/02_clean_cosing.ipynb`)
- [x] Sephora data cleaned, ingredients matched to CosIng (`notebook/03_clean_sephora.ipynb`)
- [x] MySQL database: 9 tables, load script and EU-status function (`notebook/04_sql_load.ipynb`, `sql/`)
- [x] Exploratory analysis and charts (`notebook/05_exploratory_data_analysis.ipynb`)
- [x] Hypothesis tests H1 and H4 (`notebook/06_hypothesis_tests.ipynb`)
- [x] Hypothesis tests H2 and H3: skin type and ingredient functions (`notebook/07_sephora_tests.ipynb`)
- [x] Export of flat files for Tableau (`notebook/08_tableau_export.ipynb`)
- [x] Tableau Public dashboards: safety page and skin-type page
- [x] Presentation (19 November 2026)

## Findings
**California reports vs. EU rules**
- 114,381 reports, 36,972 products, 635 companies. Titanium dioxide is in about 87% of products, so most analyses are shown without it.
- The reports name 99 different chemicals with a valid CAS number. 37 of them (37%) are banned in the EU (Annex II), 15 are restricted (Annex III), 5 are on positive lists and 42 are not listed in any annex.
- 845 reports (0.7%), 455 products (1.2%) and 84 companies (13%, about one in eight) involve an EU-banned chemical.
- The most frequent banned chemicals are formaldehyde (104 products), benzophenone (95), 1,4-dioxane (59) and styrene (52). Some are impurities or production residues: 1,4-dioxane forms as a by-product when ethoxylated ingredients are made, and ethylene oxide and styrene can remain as residues. For the others the data does not show why they are present.
- Banned chemicals show up mostly in hair care, skin care, makeup and nails. One company's batch report matters here: without La Prairie, skin care drops from 119 to 70 banned products and hair care becomes the top category (a product can belong to several categories).
- The benzophenone in these reports is benzophenone itself (CAS 119-61-9), not the UV filter benzophenone-3, which is why chemicals are matched by CAS number and not by name.

**H1: Are chemicals banned in the EU removed more often? (chi-square test)**
- Without titanium dioxide, EU-banned chemicals were removed more often: 16.7% vs. 5.9% of reports (17.5% vs. 9.0% when counting each product-chemical pair once). "Removed" is the company's own report of a removal date, and it is not verified.
- The difference is statistically significant and holds in all robustness checks (odds ratio about 1.8 to 3.3), but the effect is modest (Cramér's V 0.05 to 0.10). This is an association, not proof of cause.
- One company (La Prairie) reported 188 of the 845 banned reports in 2016, mostly benzophenone, and rarely removed them. Without this company the removal rate of banned chemicals is 19.2% (not banned: 5.9%), so the result does not depend on one company.
- "Not banned" means all other chemicals in the file, including restricted ones.

**H4 (exploratory): Do big companies remove more?**
- Inconclusive: the result changes with the definition of a "big" company, so no claim is made.

**H2 and H3: Skin type, ingredient functions and ratings (Sephora, 2,420 skincare products)**
- The Sephora review files contain only skincare, so the analysis covers the 2,420 skincare products of the 8,494 in the product file.
- 96% of ingredient mentions were matched to CosIng names. 90% of the 1.09 million reviews have a skin type.
- H2: ratings differ only negligibly between skin types (epsilon squared 0.0001). Ratings are strongly skewed to 5 stars, so rank-based tests are used.
- H3: not supported. I predicted that humectant- and emollient-rich products are rated better by dry skin and anti-sebum products better by oily skin. For all four ingredient functions the 95% bootstrap interval of the difference includes zero. Broad ingredient functions do not explain skin-type-specific ratings in this data.

![Difference between dry and oily skin](images/12_h3_difference.png)

## Limitations
- California reports end in June 2020; the Sephora reviews run until March 2023. The two sources are linked by ingredient, not by date.
- The California Safe Cosmetics Program only requires companies to report; it does not require removal. The California Toxic-Free Cosmetics Act (bans of 24 chemicals from 2025) is not in the data.
- 2009–2010 is the initial reporting wave, and 2016 is dominated by one company's batch report, so counts per year are not a trend.
- "Banned in the EU" does not mean illegal in California, and a report does not mean the chemical is harmful at the amount in the product.
- Group entries without a single CAS number (for example "lead and its compounds") cannot be matched to the EU lists.
- CosIng function labels say what an ingredient can do, not how much of it is in a product, and they are incomplete (shea butter is only labelled "skin conditioning").
- Skin type is self-reported, and reviews are not independent (446,491 authors wrote 982,854 reviews).
- Company counts use the company name (two companies appear with two IDs each).
- The EU lists are the state of June 2026 (annexes) and June 2023 (ingredient inventory), while the California reports end in June 2020. "Banned in the EU" therefore means banned today, not necessarily at the time of the report.
- The CosIng files come from a third-party copy on Hugging Face (nad949/CosIng), not directly from the European Commission. The copy has no dataset card or licence, and its download date is unknown. The ban and restriction status may differ from the current official lists.

## Repository structure
- `notebook/` – analysis notebooks (numbered; run order in "How to run")
- `sql/` – database schema, indexes and the EU-status function
- `images/` – charts used in the README and the presentation
- `environment.yml` – the Anaconda environment
- `data/` – not included (raw data from the links above; clean files are created by the notebooks)

## Author
Dr. Simindokht Gol Kar – PhD chemist (inorganic/materials chemistry) using data to support product-safety and R&D decisions.
[LinkedIn](https://www.linkedin.com/in/simindokhtgolkar)