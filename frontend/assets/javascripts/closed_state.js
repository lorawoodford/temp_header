$(function () {
    const headerDiv = document.getElementById('temp-header');
    const closeButton = document.getElementById('closeHeader');
    const showHeaderDiv = document.getElementById('unhide-alert');
    const showHeaderButton = document.getElementById('showHeader');

    // On page load, check if the header was previously closed
    if (localStorage.getItem('headerClosed') === 'true') {
        headerDiv.style.display = 'none';
        showHeaderDiv.style.removeProperty('display');
    }

    // Event listener for closing the header
    closeButton.addEventListener('click', () => {
        headerDiv.style.display = 'none';
        showHeaderDiv.style.removeProperty('display');
        localStorage.setItem('headerClosed', 'true');
    });

    // Add a button to re-open the header and reset local storage
    showHeaderButton.addEventListener('click', () => {
        headerDiv.style.removeProperty('display');
        showHeaderDiv.style.display = 'none';
        localStorage.removeItem('headerClosed');
    });

});
