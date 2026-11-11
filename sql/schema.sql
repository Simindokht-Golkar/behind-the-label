
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS reports, product_categories, products, chemicals, companies, eu_cas, eu_status, ingredient_functions, ingredients;
SET FOREIGN_KEY_CHECKS = 1;

-- one row per company
CREATE TABLE companies (
    company_id   INT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);

-- one row per product; links to its company
CREATE TABLE products (
    cdph_id      INT PRIMARY KEY,
    product_name VARCHAR(500),
    brand_name   VARCHAR(255),
    company_id   INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- one row per product and category (a product can have several)
CREATE TABLE product_categories (
    product_category_id INT AUTO_INCREMENT PRIMARY KEY,
    cdph_id             INT NOT NULL,
    primary_category_id INT,
    primary_category    VARCHAR(150),
    sub_category_id     INT,
    sub_category        VARCHAR(150),
    FOREIGN KEY (cdph_id) REFERENCES products(cdph_id)
);

-- one row per chemical (CasId); only name-level information
CREATE TABLE chemicals (
    cas_id          INT PRIMARY KEY,
    chemical_name   VARCHAR(255) NOT NULL,
    is_tio2         BOOLEAN,
    is_trade_secret BOOLEAN
);

-- one row per reported chemical entry; CAS number and EU status are stored per row
CREATE TABLE reports (
    report_id                 INT AUTO_INCREMENT PRIMARY KEY,
    cdph_id                   INT NOT NULL,
    cas_id                    INT NOT NULL,
    cas_number                VARCHAR(20),
    eu_banned                 BOOLEAN,
    eu_restricted             BOOLEAN,
    csf_id                    INT,
    csf                       VARCHAR(500),
    chemical_entry_id         INT,
    initial_date_reported     DATE,
    most_recent_date_reported DATE,
    discontinued_date         DATE,
    chemical_created_at       DATE,
    chemical_updated_at       DATE,
    chemical_date_removed     DATE,
    chemical_count            INT,
    is_removed                BOOLEAN,
    is_discontinued           BOOLEAN,
    FOREIGN KEY (cdph_id) REFERENCES products(cdph_id),
    FOREIGN KEY (cas_id)  REFERENCES chemicals(cas_id)
);

-- one row per line in an EU annex (entry numbers can repeat, so we use an automatic ID)
CREATE TABLE eu_status (
    eu_status_id  INT AUTO_INCREMENT PRIMARY KEY,
    annex         VARCHAR(3)  NOT NULL,
    ref_no        VARCHAR(20) NOT NULL,
    name          TEXT,
    inci_name     TEXT,
    inci_examples TEXT,
    cas           TEXT,
    ec            TEXT,
    product_type  TEXT,
    max_conc      TEXT,
    other_limits  TEXT,
    warnings      TEXT,
    cmr           TEXT,
    sccs_opinion  TEXT,
    last_update   DATE,
    INDEX idx_annex_ref (annex, ref_no)
);

-- one row per CAS number in an annex (the link between chemicals and the EU rules)
CREATE TABLE eu_cas (
    annex      VARCHAR(3)  NOT NULL,
    cas_single VARCHAR(20) NOT NULL,
    ref_no     VARCHAR(20) NOT NULL,
    PRIMARY KEY (annex, cas_single),
    INDEX idx_annex_ref (annex, ref_no)
);

-- one row per cosmetic ingredient (key = CosIng reference number)
CREATE TABLE ingredients (
    ingredient_id INT PRIMARY KEY,
    inci_name     TEXT NOT NULL,
    inn_name      VARCHAR(500),
    ph_eur_name   VARCHAR(500),
    cas           VARCHAR(500),
    ec            VARCHAR(500),
    description   TEXT,
    restriction   TEXT,
    last_update   DATE,
    INDEX idx_inci (inci_name(255))
);

-- one row per ingredient and function
CREATE TABLE ingredient_functions (
    ingredient_id INT NOT NULL,
    function_name VARCHAR(150) NOT NULL,
    PRIMARY KEY (ingredient_id, function_name),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);
