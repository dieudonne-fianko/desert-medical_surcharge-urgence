-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 06 juil. 2025 à 15:57
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `base_projet_tutore`
--

-- --------------------------------------------------------

--
-- Structure de la table `apl`
--

CREATE TABLE `apl` (
  `id_apl` int(11) NOT NULL,
  `id_region` varchar(10) DEFAULT NULL,
  `apl_generale` float DEFAULT NULL,
  `apl_ehpad` float DEFAULT NULL,
  `apl_ra` float DEFAULT NULL,
  `apl_sapa` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `apl`
--

INSERT INTO `apl` (`id_apl`, `id_region`, `apl_generale`, `apl_ehpad`, `apl_ra`, `apl_sapa`) VALUES
(1, 'r1', 2.7, 78366.2, 366.23, 807.06),
(2, 'r2', 2.8, 81375.1, 369.46, 783.15),
(3, 'r3', 3.2, 108846, 382.05, 956.68),
(4, 'r4', 2.2, 83458.8, 362.6, 707.375),
(5, 'r5', 1.4, 20207.7, 0, 0),
(6, 'r6', 3, 82619, 517.14, 723.72),
(7, 'r7', 3.2, 84058.8, 598.29, 1286.61),
(8, 'r8', 2.3, 86256.5, 1044.36, 1174.05),
(9, 'r9', 2.9, 84154, 426.98, 1115.48),
(10, 'r10', 3, 76014.5, 122.11, 892.73),
(11, 'r11', 3, 110015, 711.06, 899),
(12, 'r12', 3.2, 73790, 406.71, 874.37),
(13, 'r13', 2.6, 64216.1, 658.07, 579.03);

-- --------------------------------------------------------

--
-- Structure de la table `densite_medecin`
--

CREATE TABLE `densite_medecin` (
  `id_densite` int(11) NOT NULL,
  `id_region` varchar(10) DEFAULT NULL,
  `densite` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `densite_medecin`
--

INSERT INTO `densite_medecin` (`id_densite`, `id_region`, `densite`) VALUES
(1, 'r1', 345.399),
(2, 'r2', 285.904),
(3, 'r3', 340.536),
(4, 'r4', 252.667),
(5, 'r5', 324.47),
(6, 'r6', 317.376),
(7, 'r7', 291.155),
(8, 'r8', 349.722),
(9, 'r9', 287.373),
(10, 'r10', 346.819),
(11, 'r11', 339.09),
(12, 'r12', 403.2),
(13, 'r13', 269.989);

-- --------------------------------------------------------

--
-- Structure de la table `enquete_urgence`
--

CREATE TABLE `enquete_urgence` (
  `id_enquete` int(11) NOT NULL,
  `id_region` varchar(10) DEFAULT NULL,
  `nb_medecins_permanents` int(11) DEFAULT NULL,
  `nb_total_passages` int(11) DEFAULT NULL,
  `tension` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enquete_urgence`
--

INSERT INTO `enquete_urgence` (`id_enquete`, `id_region`, `nb_medecins_permanents`, `nb_total_passages`, `tension`) VALUES
(1, 'r1', 3, 85, 1),
(2, 'r2', 4, 66, 1),
(3, 'r3', 4, 84, 1),
(4, 'r4', 3, 77, 1),
(5, 'r5', 2, 77, 0),
(6, 'r6', 3, 75, 1),
(7, 'r7', 4, 91, 1),
(8, 'r8', 4, 102, 1),
(9, 'r9', 3, 70, 1),
(10, 'r10', 3, 65, 1),
(11, 'r11', 3, 75, 1),
(12, 'r12', 4, 86, 1),
(13, 'r13', 4, 79, 1);

-- --------------------------------------------------------

--
-- Structure de la table `population_region`
--

CREATE TABLE `population_region` (
  `id_population` int(11) NOT NULL,
  `id_region` varchar(10) NOT NULL,
  `id_sexe` int(11) DEFAULT NULL,
  `effectif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `population_region`
--

INSERT INTO `population_region` (`id_population`, `id_region`, `id_sexe`, `effectif`) VALUES
(1, 'r1', 1, 4032910),
(2, 'r2', 1, 1365936),
(3, 'r3', 1, 1694287),
(4, 'r4', 1, 1254728),
(5, 'r5', 1, 174337),
(6, 'r6', 1, 2709169),
(7, 'r7', 1, 2899952),
(8, 'r8', 1, 6035126),
(9, 'r9', 1, 1620129),
(10, 'r10', 1, 2990727),
(11, 'r11', 1, 3003755),
(12, 'r12', 1, 1926671),
(13, 'r13', 1, 2511416),
(14, 'r1', 2, 4227186),
(15, 'r2', 2, 1427144),
(16, 'r3', 2, 1781608),
(17, 'r4', 2, 1326751),
(18, 'r5', 2, 185825),
(19, 'r6', 2, 2834882),
(20, 'r7', 2, 3073981),
(21, 'r8', 2, 6415723),
(22, 'r9', 2, 1721183),
(23, 'r10', 2, 3200482),
(24, 'r11', 2, 3197832),
(25, 'r12', 2, 2010048),
(26, 'r13', 2, 2730171),
(27, 'r1', 3, 8260096),
(28, 'r2', 3, 2793080),
(29, 'r3', 3, 3475895),
(30, 'r4', 3, 2581479),
(31, 'r5', 3, 360162),
(32, 'r6', 3, 5544051),
(33, 'r7', 3, 5973933),
(34, 'r8', 3, 12450849),
(35, 'r9', 3, 3341312),
(36, 'r10', 3, 6191209),
(37, 'r11', 3, 6201587),
(38, 'r12', 3, 3936719),
(39, 'r13', 3, 5241587);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `id_region` varchar(10) NOT NULL,
  `nom_region` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`id_region`, `nom_region`) VALUES
('r1', 'Auvergne-Rhône-Alpes'),
('r10', 'Nouvelle-Aquitaine'),
('r11', 'Occitanie'),
('r12', 'Provence-Alpes-Côte d\'Azur'),
('r13', 'Pays de la Loire'),
('r2', 'Bourgogne-Franche-Comté'),
('r3', 'Bretagne'),
('r4', 'Centre-Val de Loire'),
('r5', 'Corse'),
('r6', 'Grand Est'),
('r7', 'Hauts-de-France'),
('r8', 'Île-de-France'),
('r9', 'Normandie');

-- --------------------------------------------------------

--
-- Structure de la table `sexe`
--

CREATE TABLE `sexe` (
  `id_sexe` int(11) NOT NULL,
  `libelle_sexe` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sexe`
--

INSERT INTO `sexe` (`id_sexe`, `libelle_sexe`) VALUES
(1, 'homme'),
(2, 'femme'),
(3, 'total(h&f)');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `apl`
--
ALTER TABLE `apl`
  ADD PRIMARY KEY (`id_apl`),
  ADD KEY `id_region` (`id_region`);

--
-- Index pour la table `densite_medecin`
--
ALTER TABLE `densite_medecin`
  ADD PRIMARY KEY (`id_densite`),
  ADD KEY `id_region` (`id_region`);

--
-- Index pour la table `enquete_urgence`
--
ALTER TABLE `enquete_urgence`
  ADD PRIMARY KEY (`id_enquete`),
  ADD KEY `id_region` (`id_region`);

--
-- Index pour la table `population_region`
--
ALTER TABLE `population_region`
  ADD PRIMARY KEY (`id_population`),
  ADD KEY `id_region` (`id_region`),
  ADD KEY `id_sexe` (`id_sexe`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id_region`);

--
-- Index pour la table `sexe`
--
ALTER TABLE `sexe`
  ADD PRIMARY KEY (`id_sexe`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `apl`
--
ALTER TABLE `apl`
  MODIFY `id_apl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `densite_medecin`
--
ALTER TABLE `densite_medecin`
  MODIFY `id_densite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `enquete_urgence`
--
ALTER TABLE `enquete_urgence`
  MODIFY `id_enquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `population_region`
--
ALTER TABLE `population_region`
  MODIFY `id_population` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `apl`
--
ALTER TABLE `apl`
  ADD CONSTRAINT `apl_ibfk_1` FOREIGN KEY (`id_region`) REFERENCES `region` (`id_region`);

--
-- Contraintes pour la table `densite_medecin`
--
ALTER TABLE `densite_medecin`
  ADD CONSTRAINT `densite_medecin_ibfk_1` FOREIGN KEY (`id_region`) REFERENCES `region` (`id_region`);

--
-- Contraintes pour la table `enquete_urgence`
--
ALTER TABLE `enquete_urgence`
  ADD CONSTRAINT `enquete_urgence_ibfk_1` FOREIGN KEY (`id_region`) REFERENCES `region` (`id_region`);

--
-- Contraintes pour la table `population_region`
--
ALTER TABLE `population_region`
  ADD CONSTRAINT `population_region_ibfk_1` FOREIGN KEY (`id_region`) REFERENCES `region` (`id_region`),
  ADD CONSTRAINT `population_region_ibfk_2` FOREIGN KEY (`id_sexe`) REFERENCES `sexe` (`id_sexe`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
