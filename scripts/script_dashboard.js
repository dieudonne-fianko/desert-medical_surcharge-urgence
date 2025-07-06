document.addEventListener('DOMContentLoaded', () => {
  const indicateurs = {
    "nb_medecins_permanents": "Nombre moyen de médecins permanents (enquete urgence 2023)",
    "nb_passages": "Nombre de passages aux urgences (enquete urgence 2023)",
    "tension": "Protocole urgence en tension déclenché (enquete urgence 2023)",
    "effectif": "Population totale (2025)",
    "hommes": "Population masculine (2025)",
    "femmes": "Population féminine (2025)",
    "apl_generale": "APL - générale (2023)",
    "apl_ehpad" : "APL - EHPAD (2021)",
    "apl_ra" : "APL - résidences autonomie (2021)",
    "apl_sapa" : "APL - services procurant une assistance aux personnes âgées (2021)",
    "densite": "Densité médicale"
  };

  const select1 = document.getElementById('indicateur1');
  const select2 = document.getElementById('indicateur2');
  const checkbox = document.getElementById('doubleInd');
  let chart;

  // Remplir les listes déroulantes
  for (const [value, label] of Object.entries(indicateurs)) {
    for (const sel of [select1, select2]) {
      const opt = document.createElement('option');
      opt.value = value;
      opt.textContent = label;
      sel.appendChild(opt.cloneNode(true));
    }
  }

  // Afficher/cacher le deuxième indicateur
  checkbox.addEventListener('change', () => {
    select2.style.display = checkbox.checked ? 'block' : 'none';
  });

  // Palette de couleurs
  function getRandomColor(i) {
    const palette = ['#264653', '#2a9d8f', '#e76f51', '#f4a261', '#457b9d', '#ffafcc'];
    return palette[i % palette.length];
  }

  // Couleur grille
  function getCouleur(desert, surcharge) {
    if (desert && surcharge) return 'red';
    if (desert && !surcharge) return 'orange';
    if (!desert && surcharge) return 'purple';
    return 'green';
  }

  // Affichage grille
  function afficherGrille() {
    fetch('?regions_statuts')
      .then(r => r.json())
      .then(data => {
        const grid = document.getElementById('gridContainer');
        grid.innerHTML = '';
        data.forEach(d => {
          const div = document.createElement('div');
          div.style.backgroundColor = getCouleur(d.desert, d.surcharge);
          div.textContent = d.region;
          grid.appendChild(div);
        });
      });
  }

  // Affichage diagramme
  function afficherDiagramme() {
    const ind1 = select1.value;
    const ind2 = checkbox.checked && select2.value ? select2.value : null;
    const query = ind2 ? `${ind1},${ind2}` : ind1;

    fetch('?indicateurs=' + query)
      .then(r => r.json())
      .then(json => {
        const ctx = document.getElementById('barChart');
        ctx.height = json.regions.length * 30;

        if (chart) chart.destroy();

        chart = new Chart(ctx, {
          type: 'bar',
          data: {
            labels: json.regions,
            datasets: json.datasets.map((d, i) => ({
              label: d.label,
              data: Object.values(d.data),
              backgroundColor: getRandomColor(i)
            }))
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: 'y',
            plugins: { legend: { position: 'top' } },
            scales: { x: { beginAtZero: true } }
          }
        });
      });
  }

  // Télécharger PNG avec fond blanc
  document.getElementById('downloadChart').addEventListener('click', () => {
    const canvas = document.getElementById('barChart');
    const tempCanvas = document.createElement('canvas');
    tempCanvas.width = canvas.width;
    tempCanvas.height = canvas.height;
    const ctx = tempCanvas.getContext('2d');
    ctx.fillStyle = '#fff';
    ctx.fillRect(0, 0, tempCanvas.width, tempCanvas.height);
    ctx.drawImage(canvas, 0, 0);
    const link = document.createElement('a');
    link.download = 'graphique_regions.png';
    link.href = tempCanvas.toDataURL('image/png');
    link.click();
  });

  // Télécharger Excel
  document.getElementById('downloadXLSX').addEventListener('click', () => {
    if (!chart) return;

    const wb = XLSX.utils.book_new();

    chart.data.datasets.forEach(dataset => {
      const rows = [["Région", dataset.label]];
      chart.data.labels.forEach((label, i) => {
        rows.push([label, dataset.data[i]]);
      });
      const ws = XLSX.utils.aoa_to_sheet(rows);
      XLSX.utils.book_append_sheet(wb, ws, dataset.label.substring(0, 31));
    });

    XLSX.writeFile(wb, 'indicateurs_regions.xlsx');
  });

  // Initialisation + boutons
  document.getElementById('refreshBtn').addEventListener('click', () => {
    afficherDiagramme();
    afficherGrille();
  });

  afficherDiagramme();
  afficherGrille();
});


