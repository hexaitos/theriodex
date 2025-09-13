document.addEventListener('DOMContentLoaded', function () {
	const form = document.getElementById('saveForm');
	const modal = document.getElementById('consentModal');
	const checkbox = document.getElementById('consentCheckbox');
	const acceptBtn = document.getElementById('acceptBtn');
	const declineBtn = document.getElementById('declineBtn');
	const hiddenConsent = document.getElementById('privacy_accepted');
	let lastFocused = null;

	function openModal() {
		lastFocused = document.activeElement;
		modal.hidden = false;
		checkbox.checked = false;
		acceptBtn.disabled = true;
		checkbox.focus();
		document.body.style.overflow = 'hidden'; 
	}

	function closeModal() {
		modal.hidden = true;
		document.body.style.overflow = '';
		if (lastFocused) lastFocused.focus();
	}

	form.addEventListener('submit', function (e) {
		if (hiddenConsent.value === '1') return;
		e.preventDefault();
		openModal();
	});

	checkbox.addEventListener('change', function () {
		acceptBtn.disabled = !checkbox.checked;
	});

	acceptBtn.addEventListener('click', function () {
		if (!checkbox.checked) return;
		hiddenConsent.value = '1';
		closeModal();
		form.submit();
	});

	declineBtn.addEventListener('click', function () {
		hiddenConsent.value = '0';
		closeModal();
	});

	document.addEventListener('keydown', function (ev) {
		if (!modal.hidden && ev.key === 'Escape') closeModal();
	});
});
