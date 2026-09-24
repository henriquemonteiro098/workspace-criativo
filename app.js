const cards = [...document.querySelectorAll('.atlas-card')];
const filters = [...document.querySelectorAll('.filter')];
const search = document.querySelector('#search');
const emptyState = document.querySelector('#empty-state');

function updateArchive() {
  const activeFilter = document.querySelector('.filter.is-active').dataset.filter;
  const query = search.value.trim().toLocaleLowerCase('pt-BR');
  let visible = 0;

  cards.forEach((card) => {
    const matchesFilter = activeFilter === 'all' || card.dataset.category === activeFilter;
    const matchesQuery = !query || card.dataset.search.includes(query) || card.textContent.toLocaleLowerCase('pt-BR').includes(query);
    const shouldShow = matchesFilter && matchesQuery;
    card.hidden = !shouldShow;
    if (shouldShow) visible += 1;
  });

  emptyState.hidden = visible !== 0;
}

filters.forEach((filter) => {
  filter.addEventListener('click', () => {
    filters.forEach((item) => item.classList.remove('is-active'));
    filter.classList.add('is-active');
    updateArchive();
  });
});

search.addEventListener('input', updateArchive);
