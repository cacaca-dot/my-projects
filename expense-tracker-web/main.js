// Variabel array untuk menyimpan semua data transaksi
let transactions = [];

// State untuk menyimpan ID transaksi yang sedang diedit (null artinya mode "Tambah")
let editingTransactionId = null;

//Fungsi untuk menghasilkan ID unik otomatis berdasarkan timestamp
const generateUniqueId = () => +new Date();

/**
 * 1. SELEKSI ELEMEN DOM UTAMA
 */
const transactionForm = document.getElementById('transactionForm');
const incomeList = document.getElementById('incomeList');
const expenseList = document.getElementById('expenseList');

// Elemen Input Form Pencatatan
const titleInput = document.getElementById('transactionFormTitleInput');
const amountInput = document.getElementById('transactionFormAmountInput');
const dateInput = document.getElementById('transactionFormDateInput');
const typeInput = document.getElementById('transactionFormTypeSelect');
const submitBtn = document.querySelector('.tracker-form__submit'); // Tombol Simpan/Update

// Elemen Form Pencarian
const searchForm = document.getElementById('searchTransactionForm');
const searchInput = document.getElementById('searchTransactionFormTitleInput');


/**
 * 2. FUNGSI RENDER TRANSAKSI 
 */
function renderTransactions(filteredTransactions = transactions) {
  // Kosongkan kontainer terlebih dahulu sebelum mengisi ulang
  incomeList.innerHTML = '';
  expenseList.innerHTML = '';

  filteredTransactions.forEach(transaction => {
    // Buat setiap elemen kartu dengan document.createElement()
    const card = document.createElement('div');
    card.setAttribute('data-testid', 'transactionItem');
    card.className = 'transaction-card'; 

    // Elemen Judul/Keterangan
    const h3 = document.createElement('h3');
    h3.setAttribute('data-testid', 'transactionItemTitle');
    h3.textContent = transaction.title;

    // Elemen Nominal (Visual menggunakan format titik)
    const pAmount = document.createElement('p');
    pAmount.setAttribute('data-testid', 'transactionItemAmount');
    pAmount.textContent = `Nominal: Rp${transaction.amount.toLocaleString('id-ID')}`;

    // Elemen Tanggal (Visual menggunakan format DD/MM/YYYY)
    const pDate = document.createElement('p');
    pDate.setAttribute('data-testid', 'transactionItemDate');
    const dateParts = transaction.date.split('-');
    if (dateParts.length === 3) {
      pDate.textContent = `Tanggal: ${dateParts[2]}/${dateParts[1]}/${dateParts[0]}`;
    } else {
      pDate.textContent = `Tanggal: ${transaction.date}`;
    }

    // Elemen Tipe
    const pType = document.createElement('p');
    pType.setAttribute('data-testid', 'transactionItemType');
    const typeLabel = transaction.type === 'income' ? 'Pemasukan' : 'Pengeluaran';
    pType.textContent = `Tipe: ${typeLabel}`;

    // Kontainer Tombol Aksi
    const actionDiv = document.createElement('div');

    // Tombol Ubah Tipe
    const changeTypeBtn = document.createElement('button');
    changeTypeBtn.setAttribute('data-testid', 'transactionItemEditTypeButton');
    changeTypeBtn.textContent = 'Ubah Tipe';
    changeTypeBtn.onclick = function () {
      transaction.type = transaction.type === 'income' ? 'expense' : 'income';
      dispatchDataUpdate();
    };

    // Tombol Edit Data
    const editBtn = document.createElement('button');
    editBtn.textContent = 'Edit';
    editBtn.onclick = function () {
      // Mengisi formulir otomatis dengan data yang dipilih
      titleInput.value = transaction.title;
      amountInput.value = transaction.amount;
      dateInput.value = transaction.date;
      typeInput.value = transaction.type;
      
      // Kunci ID ke state editing dan ubah teks tombol utama
      editingTransactionId = transaction.id;
      if (submitBtn) submitBtn.textContent = 'Perbarui';
    };

    // Tombol Hapus Data
    const deleteBtn = document.createElement('button');
    deleteBtn.setAttribute('data-testid', 'transactionItemDeleteButton');
    deleteBtn.textContent = 'Hapus';
    deleteBtn.onclick = function () {
      transactions = transactions.filter(t => t.id !== transaction.id);
      
      // Jika data yang dihapus sedang dalam proses edit, batalkan mode edit
      if (editingTransactionId === transaction.id) {
        resetFormMode();
      }
      dispatchDataUpdate();
    };

    // Susun elemen tombol ke dalam kontainer aksi
    actionDiv.appendChild(changeTypeBtn);
    actionDiv.appendChild(editBtn); // Menyisipkan tombol edit baru
    actionDiv.appendChild(deleteBtn);

    card.appendChild(h3);
    card.appendChild(pAmount);
    card.appendChild(pDate);
    card.appendChild(pType);
    card.appendChild(actionDiv);

    // Masukkan kartu ke kontainer yang tepat
    if (transaction.type === 'income') {
      incomeList.appendChild(card);
    } else {
      expenseList.appendChild(card);
    }
  });
}


/**
 * 3. FORM SUBMIT HANDLER 
 */
transactionForm.addEventListener('submit', function (e) {
  e.preventDefault();

  const title = titleInput.value.trim();
  const amount = parseInt(amountInput.value, 10);
  const date = dateInput.value;
  const type = typeInput.value;

  if (!title) {
    alert('Keterangan tidak boleh kosong!');
    return;
  }
  if (isNaN(amount) || amount < 1) {
    alert('Nominal harus berupa angka bernilai minimal 1!');
    return;
  }

  if (editingTransactionId !== null) {
    transactions = transactions.map(t => {
      if (t.id === editingTransactionId) {
        return { ...t, title, amount, date, type };
      }
      return t;
    });
    resetFormMode();
  } else {
    const newTransaction = {
      id: generateUniqueId(),
      title,
      amount,
      date,
      type
    };
    transactions.push(newTransaction);
    transactionForm.reset(); 
  }

  dispatchDataUpdate();
});

// Fungsi pembantu untuk mengembalikan formulir ke mode "Tambah" semula
function resetFormMode() {
  editingTransactionId = null;
  transactionForm.reset();
  if (submitBtn) submitBtn.textContent = 'Simpan';
}


/**
 * 4. PANEL REKAPITULASI/DASBOR 
 */
function updateDashboard() {
  // Hitung total pemasukan, total pengeluaran, dan saldo
  const totalIncome = transactions
    .filter(t => t.type === 'income')
    .reduce((sum, t) => sum + t.amount, 0);

  const totalExpense = transactions
    .filter(t => t.type === 'expense')
    .reduce((sum, t) => sum + t.amount, 0);

  const balance = totalIncome - totalExpense;

  const balanceEl = document.querySelector('.tracker-summary__balance-amount');
  const totalIncomeEl = document.querySelector('.tracker-summary__stat-amount--income');
  const totalExpenseEl = document.querySelector('.tracker-summary__stat-amount--expense');

  // Tampilkan hasilnya ke elemen yang sesuai di HTML
  if (balanceEl) {
    balanceEl.textContent = balance < 0 
      ? `-Rp ${Math.abs(balance).toLocaleString('id-ID')}` 
      : `Rp ${balance.toLocaleString('id-ID')}`;
  }
  if (totalIncomeEl) totalIncomeEl.textContent = `Rp ${totalIncome.toLocaleString('id-ID')}`;
  if (totalExpenseEl) totalExpenseEl.textContent = `Rp ${totalExpense.toLocaleString('id-ID')}`;
}


/**
 * 5. WEB STORAGE & MANAGEMENT CUSTOM EVENT 
 */
function saveToLocalStorage() {
  // Data transaksi disimpan ke localStorage menggunakan JSON.stringify()
  localStorage.setItem('transactions', JSON.stringify(transactions));
}

function dispatchDataUpdate() {
  saveToLocalStorage();
  //  Kirim sinyal kustom setiap kali data berubah
  document.dispatchEvent(new Event('transaction:updated'));
}

//  Listener tunggal untuk merender dan update dasbor
document.dispatchEvent(new Event('transaction:updated'));
document.addEventListener('transaction:updated', () => {
  //  Memastikan fitur pencarian tetap sinkron saat data dimutasi
  if (searchInput && searchInput.value.trim() !== '') {
    handleSearch();
  } else {
    renderTransactions();
  }
  updateDashboard();
});


/**
 * 6. FITUR INTERAKTIF PENCARIAN 
 */
function handleSearch() {
  //  Filter array transaksi berdasarkan kata kunci judul
  const keyword = searchInput.value.toLowerCase().trim();

  //  Jika dikosongkan, tampilkan kembali seluruh daftar transaksi
  if (keyword === '') {
    renderTransactions(transactions);
    return;
  }

  const filtered = transactions.filter(t => t.title.toLowerCase().includes(keyword));
  renderTransactions(filtered);
}

if (searchForm) {
  searchForm.addEventListener('submit', function (e) {
    e.preventDefault();
    handleSearch();
  });
}

//  Tambahkan event listener 'input' pada kolom pencarian
if (searchInput) {
  searchInput.addEventListener('input', handleSearch);
}


/**
 * 7. INISIALISASI LOADING HALAMAN AWAL 
 */
function init() {
  // Dimuat kembali saat halaman dibuka menggunakan JSON.parse()
  const storedTransactions = localStorage.getItem('transactions');
  if (storedTransactions) {
    transactions = JSON.parse(storedTransactions);
  }
  renderTransactions();
  updateDashboard();
}

init();