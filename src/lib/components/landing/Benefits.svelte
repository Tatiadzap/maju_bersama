<script lang="ts">
  import StickyScrollReveal from "../effects/sticky-scroll-reveal/StickyScrollReveal.svelte";

	const content = [
		{
			title: 'Profil Pengguna yang Menarik',
			description:
				'Buat CV yang menonjol dan mudah ditemukan oleh pemberi kerja inklusif. Tampilkan keahlian dan pengalaman Anda secara profesional dan dapatkan perhatian yang Anda layak.'
		},
		{
			title: 'Rekomendasi Pekerjaan yang Dipersonalisasi',
			description:
				'Dapatkan rekomendasi untuk pekerjaan, peluang, dan acara yang relevan berdasarkan profil, minat, dan kebutuhan Anda. Kami memastikan Anda menemukan kesempatan yang tepat untuk berkembang.'
		},
		{
			title: 'Acara untuk Mengasah Keterampilan Anda',
			description:
				"Ambil langkah selanjutnya dalam pencarian kerja Anda dengan bergabung dalam pelatihan, lokakarya resume, sesi networking, dan lebih banyak acara lainnya yang dirancang khusus untuk membantu Anda mengasah keterampilan dan meningkatkan peluang kerja."
		},
		{
			title: 'Konten Karir yang Menginspirasi',
			description:
				"Dapatkan inspirasi karir melalui postingan, video, dan artikel tentang kisah sukses, jalur karir, dan peluang yang mungkin tidak pernah Anda pertimbangkan sebelumnya. Kami hadir untuk membantu Anda menemukan potensi Anda yang sesungguhnya."
		}
	];
</script>

  <div class="w-screen">
    <StickyScrollReveal {content} />
  </div>
