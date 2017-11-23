// All this logic will automatically be available in application.js.
function query(query, node) {
	return (node || document).querySelector(query);
}
function querys(query, node) {
	return (node || document).querySelectorAll(query);
}

var imageUrls = [
	'https://i.pinimg.com/736x/72/2b/07/722b07895707baa990e9c2fe64105521--memes-funny-animal.jpg',
	'http://images2.fanpop.com/images/photos/3600000/silly-puppy-animal-humor-3660987-400-405.jpg',
	'https://media1.popsugar-assets.com/files/thumbor/D8uzF8v6KdHGh8R6MKDgD_mIf6s/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2013/04/15/4/192/1922243/cc80f11369b518e6_06767b0497d811e2858a22000a1f9711_7/i/Silly-Animal-Memes.jpg'
];


document.addEventListener('DOMContentLoaded', function () {

	var welcomeCarousel = query('#welcome-carousel');
	var carouselImg = query('img', welcomeCarousel);
	var imgIndex = 0;

	function nextImage () {
		carouselImg.src = imageUrls[imgIndex];
		imgIndex = (imgIndex + 1) % imageUrls.length; 
	}
	if (welcomeCarousel) {
		welcomeCarousel.addEventListener('click', nextImage);
		setInterval(nextImage, 2000);
	}
});