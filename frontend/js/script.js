document.addEventListener("DOMContentLoaded", function() {
    fetchProducts();

    const productForm = document.getElementById('#productForm');
    productForm.addEventListener('submit', function(event) {
        event.preventDefault();
        addProduct(new FormData(productForm));
    });

    const fetchStatsButton = document.querySelector('#statistics button');
    fetchStatsButton.addEventListener('click', function() {
        fetchStatistics();
    });
});

function fetchProducts() {
    fetch('http://furniture-store/backend/api/products.php')
        .then(response => response.json())
        .then(data => displayProducts(data))
        .catch(error => console.error('Error fetching products:', error));
}

function displayProducts(products) {
    const container = document.getElementById('productsContainer');
    container.innerHTML = '';
    products.forEach(product => {
        const card = document.createElement('div');
        card.className = 'product-card';
        card.innerHTML = `
            <h3>${product.Name}</h3>
            <p>${product.Description}</p>
            <p>Ціна: ${product.Price} грн</p>
            <p>Кількість на складі: ${product.Stock}</p>
            <p>Категорія: ${product.CategoryID}</p>
            <p>Виробник: ${product.Manufacturer}</p>
        `;
        card.addEventListener('click', () => fetchProductDetails(product.ID));
        container.appendChild(card);
    });
}

function fetchProductDetails(productId) {
    fetch(`http://furniture-store/backend/api/product_details.php?id=${productId}`)
        .then(response => response.json())
        .then(data => showProductDetails(data))
        .catch(error => console.error('Error fetching product details:', error));
}

function showProductDetails(details) {
    document.getElementById('modalProductName').textContent = details.ProductName;
    document.getElementById('modalCustomerName').textContent = details.CustomerName;
    document.getElementById('modalSellerName').textContent = details.SellerName;
    document.getElementById('modalOrderDate').textContent = details.OrderDate;
    document.getElementById('modalOrderStatus').textContent = details.OrderStatus;
    document.getElementById('modalProductPrice').textContent = details.Price;

    const modal = document.getElementById('productModal');
    modal.style.display = 'block';
}

function closeModal() {
    const modal = document.getElementById('productModal');
    modal.style.display = 'none';
}

function searchProducts() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toLowerCase();
    const cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        const name = card.querySelector('h3').textContent.toLowerCase();
        if (name.includes(filter)) {
            card.style.display = '';
        } else {
            card.style.display = 'none';
        }
    });
}

function addProduct(formData) {
    fetch('http://furniture-store/backend/api/upload.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            fetchProducts();
        } else {
            alert(data.error);
        }
    })
    .catch(error => console.error('Error adding product:', error));
}

function showSection(sectionId) {
    const sections = document.querySelectorAll('.section');
    sections.forEach(section => {
        section.style.display = 'none';
    });
    document.getElementById(sectionId).style.display = 'block';
}

function loadTable() {
    const tableSelect = document.getElementById('tableSelect').value;
    fetch(`http://furniture-store/backend/api/load_table.php?table=${tableSelect}`)
        .then(response => response.json())
        .then(data => displayTable(data, tableSelect))
        .catch(error => console.error('Error loading table:', error));
}

function displayTable(data, tableName) {
    const tableContent = document.getElementById('tableContent');
    tableContent.innerHTML = '';

    if (data.length === 0) {
        tableContent.innerHTML = '<p>No data available.</p>';
        return;
    }

    const table = document.createElement('table');
    table.className = 'management-table';

    // Create table header
    const thead = document.createElement('thead');
    const headerRow = document.createElement('tr');

    Object.keys(data[0]).forEach(key => {
        const th = document.createElement('th');
        th.innerText = key;
        headerRow.appendChild(th);
    });

    // Add Edit and Delete actions
    const actionsTh = document.createElement('th');
    actionsTh.innerText = 'Дії';
    headerRow.appendChild(actionsTh);

    thead.appendChild(headerRow);
    table.appendChild(thead);

    // Create table body
    const tbody = document.createElement('tbody');
    data.forEach(row => {
        const tr = document.createElement('tr');
        Object.values(row).forEach(value => {
            const td = document.createElement('td');
            td.innerText = value;
            tr.appendChild(td);
        });

        // Add Edit and Delete buttons
        const actionsTd = document.createElement('td');
        actionsTd.innerHTML = `
            <button onclick="editRow(${row.ID}, '${tableName}')">Редагувати</button>
            <button onclick="deleteRow(${row.ID}, '${tableName}')">Видалити</button>
        `;
        tr.appendChild(actionsTd);

        tbody.appendChild(tr);
    });

    table.appendChild(tbody);
    tableContent.appendChild(table);

    // Add form for adding a new row
    const form = document.createElement('form');
    form.id = 'managementForm';
    form.innerHTML = `
        ${Object.keys(data[0]).map(key => `
            <label for="${key}">${key}:</label>
            <input type="text" id="${key}" name="${key}" required><br>
        `).join('')}
        <button type="submit">Додати запис</button>
    `;
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        addRow(new FormData(form), tableName);
    });

    tableContent.appendChild(form);
}

function editRow(id, tableName) {
    fetch(`http://furniture-store/backend/api/load_row.php?id=${id}&table=${tableName}`)
        .then(response => response.json())
        .then(data => {
            const form = document.createElement('form');
            form.id = 'editForm';
            form.innerHTML = `
                ${Object.keys(data).map(key => `
                    <label for="edit_${key}">${key}:</label>
                    <input type="text" id="edit_${key}" name="${key}" value="${data[key]}" required><br>
                `).join('')}
                <button type="submit">Зберегти зміни</button>
                <button type="button" onclick="cancelEdit()">Скасувати</button>
            `;
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                updateRow(new FormData(form), tableName, id);
            });

            const tableContent = document.getElementById('tableContent');
            tableContent.innerHTML = '';
            tableContent.appendChild(form);
        })
        .catch(error => console.error('Error fetching row data:', error));
}

function updateRow(formData, tableName, id) {
    formData.append('tableName', tableName);
    formData.append('id', id);
    fetch('http://furniture-store/backend/api/update_row.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            loadTable();
        } else {
            alert(data.error);
        }
    })
    .catch(error => console.error('Error updating row:', error));
}

function cancelEdit() {
    loadTable();
}

function deleteRow(id, tableName) {
    fetch('http://furniture-store/backend/api/delete_row.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id, tableName })
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            loadTable();
        } else {
            alert(data.error);
        }
    })
    .catch(error => console.error('Error deleting row:', error));
}

function addRow(formData, tableName) {
    formData.append('tableName', tableName);
    fetch('http://furniture-store/backend/api/add_row.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert(data.message);
            loadTable();
        } else {
            alert(data.error);
        }
    })
    .catch(error => console.error('Error adding row:', error));
}

function fetchStatistics() {
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;

    fetch(`http://furniture-store/backend/api/statistics.php?startDate=${startDate}&endDate=${endDate}`)
        .then(response => response.json())
        .then(data => displayStatistics(data))
        .catch(error => console.error('Error fetching statistics:', error));
}

function displayStatistics(data) {
    const statisticsContainer = document.getElementById('statisticsContainer');
    statisticsContainer.innerHTML = '';

    const managerStatsTable = document.createElement('table');
    managerStatsTable.className = 'stats-table';
    managerStatsTable.innerHTML = `
        <thead>
            <tr>
                <th>ПІБ Менеджера</th>
                <th>Кількість проданих товарів</th>
            </tr>
        </thead>
        <tbody>
            ${data.managerStats.map(stat => `
                <tr>
                    <td>${stat.Manager}</td>
                    <td>${stat.SoldProducts}</td>
                </tr>
            `).join('')}
        </tbody>
    `;

    const typeStatsTable = document.createElement('table');
    typeStatsTable.className = 'stats-table';
    typeStatsTable.innerHTML = `
        <thead>
            <tr>
                <th>Тип товару</th>
                <th>Кількість проданих товарів</th>
            </tr>
        </thead>
        <tbody>
            ${data.typeStats.map(stat => `
                <tr>
                    <td>${stat.ProductType}</td>
                    <td>${stat.SoldProducts}</td>
                </tr>
            `).join('')}
        </tbody>
    `;

    statisticsContainer.appendChild(managerStatsTable);
    statisticsContainer.appendChild(typeStatsTable);
}


function downloadPDF() {
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;

    window.open(`http://furniture-store/backend/api/statistics_pdf.php?startDate=${startDate}&endDate=${endDate}`, '_blank');
}

function showSection(sectionId) {
    const sections = document.querySelectorAll('.section');
    sections.forEach(section => {
        section.style.display = 'none';
    });
    document.getElementById(sectionId).style.display = 'block';
}

// Показати розділ "Документи" при завантаженні сторінки
document.addEventListener('DOMContentLoaded', function() {
    showSection('documents');
});
