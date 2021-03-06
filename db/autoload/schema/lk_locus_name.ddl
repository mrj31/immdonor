DROP TABLE IF EXISTS lk_locus_name;

CREATE TABLE lk_locus_name
(
  
  name VARCHAR(100) NOT NULL
    COMMENT "Name or identifier",
  
  description VARCHAR(250)
    COMMENT "Free text to expand upon details",
  
  link VARCHAR(2000)
    COMMENT "Link to URL",
  
  PRIMARY KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
  COMMENT "Controlled vocabulary for the set of HLA loci or genes.";
