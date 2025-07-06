<?php
$pdo = new PDO("mysql:host=localhost;dbname=base_projet_tutore;charset=utf8mb4", "root", "");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

function getRegionStatuts($pdo) {
  $regions = $pdo->query("SELECT id_region, nom_region FROM region")->fetchAll(PDO::FETCH_KEY_PAIR);
  $apl = $pdo->query("SELECT id_region, apl_generale FROM apl")->fetchAll(PDO::FETCH_KEY_PAIR);
  $passages = $pdo->query("SELECT id_region, nb_total_passages FROM enquete_urgence")->fetchAll(PDO::FETCH_KEY_PAIR);
  $medecins = $pdo->query("SELECT id_region, nb_medecins_permanents FROM enquete_urgence")->fetchAll(PDO::FETCH_KEY_PAIR);

  $result = [];
  foreach ($regions as $id => $nom) {
    $aplVal = isset($apl[$id]) ? floatval($apl[$id]) : null;
    $passage = isset($passages[$id]) ? floatval($passages[$id]) : null;
    $medecin = isset($medecins[$id]) ? floatval($medecins[$id]) : null;

    $desert = ($aplVal !== null && $aplVal < 2.5);
    $surcharge = ($medecin !== null && $medecin > 0 && $passage / $medecin > 24);

    $result[] = [
      "region" => $nom,
      "desert" => $desert,
      "surcharge" => $surcharge
    ];
  }

  return $result;
}

if (isset($_GET['regions_statuts'])) {
  header('Content-Type: application/json');
  echo json_encode(getRegionStatuts($pdo));
  exit;
}

if (isset($_GET['indicateurs'])) {
  $indicateurs = [
    "nb_medecins_permanents" => ["table" => "enquete_urgence", "col" => "nb_medecins_permanents", "label" => "Nombre moyen de médecins permanents (enquete urgence 2023)"],
    "nb_passages" => ["table" => "enquete_urgence", "col" => "nb_total_passages", "label" => "Nombre de passages aux urgences (enquete urgence 2023)"],
    "tension" => ["table" => "enquete_urgence", "col" => "tension", "label" => "Protocole urgence en tension déclenché (enquete urgence 2023)"],
    "apl_generale" => ["table" => "apl", "col" => "apl_generale", "label" => "APL - générale (2023)"],
    "apl_ehpad" => ["table" => "apl", "col" => "apl_ehpad", "label" => "APL - EHPAD (2021)"],
    "apl_ra" => ["table" => "apl", "col" => "apl_ra", "label" => "APL - résidences autonomie (2021)"],
    "apl_sapa" => ["table" => "apl", "col" => "apl_sapa", "label" => "APL - services procurant une assistance aux personnes âgées (2021)"],
    "densite" => ["table" => "densite_medecin", "col" => "densite", "label" => "Densité de médecins généralistes pour 100.000 habitants (2023)"],
    "effectif" => ["custom" => true, "label" => "Population totale (2025)", "sexe" => 3],
    "hommes" => ["custom" => true, "label" => "Population masculine (2025)", "sexe" => 1],
    "femmes" => ["custom" => true, "label" => "Population féminine (2025)", "sexe" => 2]
  ];

  $regions = $pdo->query("SELECT id_region, nom_region FROM region")->fetchAll(PDO::FETCH_KEY_PAIR);
  $selected = explode(",", $_GET['indicateurs']);
  $data = [];

  foreach ($selected as $ind) {
    if (!isset($indicateurs[$ind])) continue;
    $meta = $indicateurs[$ind];
    $vals = [];

    if (isset($meta["custom"])) {
      $stmt = $pdo->prepare("SELECT id_region, effectif FROM population_region WHERE id_sexe = ?");
      $stmt->execute([$meta["sexe"]]);
      while ($row = $stmt->fetch()) {
        $vals[$regions[$row["id_region"]]] = floatval($row["effectif"]);
      }
    } else {
      $sql = "SELECT id_region, {$meta['col']} as val FROM {$meta['table']}";
      foreach ($pdo->query($sql) as $row) {
        $vals[$regions[$row['id_region']]] = floatval($row['val']);
      }
    }

    $data[] = ["label" => $meta['label'], "data" => $vals];
  }

  $labels = array_values($regions);
  header('Content-Type: application/json');
  echo json_encode(["regions" => $labels, "datasets" => $data]);
  exit;
}
?>


<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="keywords" content="déserts médicaux, surcharge des urgences, indicateurs santé, France, santé publique, tableau de bord, visualisation données">
  <meta name="description" content="Comprenez les déserts médicaux et la surcharge des urgences grâce à un tableau de bord interactif. Comparez les régions de France via des indicateurs clairs et visuels.">
  <meta name="author" content="Dieu-Donné FIANKO,Sayeh FATEN,Zoughbi MERIEM">
  <title>Tableau de bord -- Déserts médicaux et Surcharge des urgences</title>
  <link rel="stylesheet" href="../styles/style_dashboard.css" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link rel="icon" href="../images/favicon.png">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body>
  <header>
      <div class="logo-zone">
          <nav>
              <a href="../index.html#accueil">Accueil</a>
              <a href="../index.html#apropos">A propos</a>
              <a href="../index.html#data">Données & Méthodes</a>
              <a href="../index.html#dashboard">Visualisations</a>
              <a href="../index.html#contact">Contact</a>
          </nav>
      </div>
  </header>

  <main class="dashboard">
    <aside class="sidebar">
      <div class="toolbar">
        <div class="checkbox-wrapper">
          <label><input type="checkbox" id="doubleInd" /> Affichage double indicateur</label>
        </div>
        <select id="indicateur1" class="input"></select>
        <select id="indicateur2" class="input" style="display: none;"></select>
        <div class="toolbar-buttons">
          <button id="refreshBtn" class="btn">Actualiser</button>
          <button id="downloadChart" class="btn">Télécharger en PNG</button>
          <button id="downloadXLSX" class="btn">Télécharger en Excel</button>
        </div>
      </div>
    </aside>

    <section class="charts">
      <div class="chart-card">
        <canvas id="barChart"></canvas>
      </div>
      <div class="chart-card">
        <div id="gridContainer" class="grid-13"></div>
        <div class="legend">
          <div><div class="color-box" style="background:green"></div>Régions exemptes</div>
          <div><div class="color-box" style="background:orange"></div>Régions touchées par la désertification médicale</div>
          <div><div class="color-box" style="background:purple"></div>Régions touchées par la surcharge des urgences</div>
          <div><div class="color-box" style="background:red"></div>Régions touchées par la désertification médicale et la surcharge des urgences</div>
        </div>
      </div>
    </section>
  </main>

  <footer id="pied-de-page">
      <div class="footer-logos">
          <img src="../images/uspn.png" alt="Logo Université Sorbonne Paris Nord">
          <img src="../images/smhb.png" alt="Logo UFR Santé Médecine Biologie Humaine">
      </div>
      <p>
          Projet tutoré – Master 1 Santé Publique, parcours Informatique Biomédicale<br>
          Université Sorbonne Paris Nord – UFR SMBH | Année académique 2024–2025
      </p>
      <p class="footer-credits">© <span id="annee-courante"></span> – Tous droits réservés</p>
  </footer>
  <script src="../scripts/script_dashboard.js"></script>
  <script src="../scripts/script_index.js"></script>
</body>
</html>
