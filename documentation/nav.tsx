"implementation";

window.addEventListener('popstate', (event) => {
	console.log('Location changed to:', window.location.pathname);
});

export function NavigateToPage(destination: string) {
	window.dispatchEvent(
		new CustomEvent('navigate',{
			detail: {
				destination: `/docs/${destination}`
			}
		} as any)
	);
}
