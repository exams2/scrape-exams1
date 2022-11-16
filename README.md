# scrape-exams1

linkuri interesante

- iteme random:
  - <http://exams.ro/scripts/center.php?s=undefined>

- listă instituții din home page:
  - <http://exams.ro/>
  - opțiuni dropdown pentru instituții

- listă de facultăți și ani
  - <http://exams.ro/scripts/get_facultate.php?get_data=5>
  - unde instituție  `get_data = 5,6,7,13,14`
  - în exemplu `get_data=5` e 'Politehnica Bucuresti'
  - primești dropdowns cu facultăți și ani

- listă de materii
  - <http://exams.ro/scripts/get_materie.php?get_data=8&get_data2=1>
  - `get_data` este facultatea din dropdown de mai sus, exemplu 8 = "Automatica"
  - `get_data2 = 1,2,3,4` este anu din dropdown anii hardcodați I-IV
  - primești dropdown cu materii

- listă de subiecte
  - <http://exams.ro/scripts/menu_result.php?tags=USO&id=8>
  - `tags` e numele materiei din dropdownu trecut
  - `tags` primește urlencode dacă are spații
  - `id=8` este id-u facultății, exemplu 8 = "Automatica"
  - primești link-uri de forma `http://exams.ro/s.php?s=98` și javascriptuleț aferent

- detalii subiect
  - <http://exams.ro/s.php?s=98>
  - s = ID subiect
  - primești:
    - instituție, facultate, materie, prof, sesiune, serie, dată
    - adăugat de (!! NARC !!)
    - atașamente vin așa: `<a href="javascript:void(0);" onclick="downloadS('98/test grila.pdf')" class="download">test grila.pdf</a>`
    - care desigur îți dă un URL `98/test grila.pdf` pe care îl bagi aici:

- download atașament
  - <http://exams.ro/scripts/downloads.php?file=98/test%20grila.pdf>
  - file = urlencode de la atașamentu de mai sus
