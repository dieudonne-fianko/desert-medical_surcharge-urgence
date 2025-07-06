CREATE DATABASE IF NOT EXISTS base_projet_tutore;

CREATE TABLE region (
  id_region VARCHAR(10) PRIMARY KEY,
  nom_region VARCHAR(100) NOT NULL
);

CREATE TABLE sexe (
  id_sexe INT PRIMARY KEY,
  libelle_sexe VARCHAR(10)
);


CREATE TABLE population_region (
  id_population INT PRIMARY KEY AUTO_INCREMENT,
  id_region VARCHAR(10),
  id_sexe INT,
  effectif INT,
  FOREIGN KEY (id_region) REFERENCES region(id_region),
  FOREIGN KEY (id_sexe) REFERENCES sexe(id_sexe),
);

CREATE TABLE apl (
  id_apl INT PRIMARY KEY AUTO_INCREMENT,
  id_region VARCHAR(10),
  apl_generale FLOAT,
  apl_ehpad FLOAT,
  apl_ra FLOAT,
  apl_sapa FLOAT,
  FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE densite_medecin (
  id_densite INT PRIMARY KEY AUTO_INCREMENT,
  id_region VARCHAR(10),
  densite FLOAT,
  FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE enquete_urgence (
  id_enquete INT PRIMARY KEY AUTO_INCREMENT,
  id_region VARCHAR(10),
  nb_medecins_permanents INT,
  nb_total_passages INT,
  tension BOOLEAN,
  FOREIGN KEY (id_region) REFERENCES region(id_region)
);

