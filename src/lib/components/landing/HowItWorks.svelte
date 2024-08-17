<script lang="ts">
  // Data for each item in the list
  export let items = [
  {
    title: 'Buat CV yang Menarik',
    description: 'Buat CV profesional yang menonjol dan mudah ditemukan oleh pemberi kerja.',
    svg: `
      <svg viewBox="0 0 172 172" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-28 h-28 min-[576px]:h-48 min-[576px]:w-40">
        <circle cx="86" cy="86" r="86" fill="rgb(197, 138, 255)"></circle>
        <path d="M34 74.2914C34 45.9641 57.0573 23 85.5 23C113.943 23 137 45.9641 137 74.2914C137 90.7342 128.882 104.771 116.617 113.843C119.663 115.251 121.194 117.126 120.463 119.491C118.586 125.564 81.8407 131.511 56.8628 116.888C43.8295 109.258 34 96.0271 34 74.2914Z" fill="rgb(211, 251, 82)"></path>
        <path d="M56.1911 132.701H120.463V150H50.5398V124.711C50.5398 109.295 124.769 106.191 120.463 120.235C117.607 129.548 34 138.567 34 74.6868C34 46.1411 57.0573 23 85.5 23C113.943 23 137 46.1411 137 74.6868C137 89.4559 130.55 102.299 120.463 111.389" stroke="#000000" stroke-linecap="square" stroke-linejoin="bevel" fill="none"></path>
        <path d="M48.4462 89C42.4433 66.3333 55.675 43.0524 78 37" stroke="#000000" stroke-linejoin="bevel" fill="none"></path>
        <path d="M156 53.5273C145.748 42.8896 134.336 39.1624 109 58C130.664 36.926 127.727 30.4182 120.482 17C130.664 25.2 137.621 29.4213 151.512 18.5292C141.637 32.7496 146.85 41.026 156 53.5273Z" fill="rgb(255, 255, 255)"></path>
      </svg>
    `
  },
  {
    title: 'Asah Keterampilan di Workshop',
    description: 'Tingkatkan keterampilan dengan mengikuti workshop yang dirancang khusus untuk kebutuhan Anda.',
    svg: `
          <svg viewbox="0 0 172 172" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-28 h-28 min-[576px]:h-48 min-[576px]:w-40">
            <circle cx="86" cy="86" r="86" fill="rgb(197, 138, 255)"></circle>
            <path d="M129.856 63.749C129.014 73.5087 124.584 82.447 117.915 89.3651C112.154 95.3408 106.94 102.309 106.266 110.128L105.07 124L90.16 124L61.1018 124L62.3368 109.681C63.0025 101.963 59.0977 95.0645 54.4797 89.1266C49.1254 82.2421 46.312 73.397 47.1441 63.749C49.0375 41.7962 69.0881 24 91.9283 24C114.769 24 131.749 41.7962 129.856 63.749Z" fill="rgb(211, 251, 82)"></path>
            <path d="M61.1018 124L62.3368 109.681C63.0025 101.963 59.0977 95.0645 54.4797 89.1266C49.1254 82.2421 46.312 73.397 47.1441 63.749C49.0375 41.7962 69.0881 24 91.9283 24C114.769 24 131.749 41.7962 129.856 63.749C129.014 73.5087 124.584 82.447 117.915 89.3651C112.154 95.3408 106.94 102.309 106.266 110.128L105.07 124H61.1018ZM61.1018 124C70.6619 115.808 89.2598 92.2892 87.1717 63.749C84.5615 28.0736 61.3959 42.3356 69.8791 63.749C78.3622 85.1623 96.8948 79.4879 105.07 54.7359C100.409 74.811 92.5985 109.277 90.16 124" stroke="#000000" stroke-linejoin="bevel" fill="none"></path>
            <path d="M87.1717 63.749C87.4989 68.2208 87.3182 72.5694 86.744 76.7551C80.3118 78.048 73.9425 74.006 69.8791 63.749C61.3959 42.3356 84.5615 28.0736 87.1717 63.749Z" fill="rgb(255, 255, 255)"></path>
            <path d="M105.07 124L106.266 110.128C106.94 102.309 112.154 95.3408 117.915 89.3651C124.584 82.447 129.014 73.5087 129.856 63.749C131.749 41.7962 114.769 24 91.9283 24C69.0881 24 49.0375 41.7962 47.1441 63.749C46.312 73.397 49.1254 82.2421 54.4797 89.1266C59.0977 95.0645 63.0025 101.963 62.3368 109.681L61.1018 124C70.6619 115.808 89.2598 92.2892 87.1717 63.749C84.5615 28.0736 61.3959 42.3356 69.8791 63.749C78.3622 85.1623 96.8948 79.4879 105.07 54.7359C100.409 74.811 92.5985 109.277 90.16 124" stroke="#000000" stroke-linejoin="bevel" fill="none"></path>
            <path d="M105 124C102.339 139.324 60.919 143.707 65.3283 135.775C70.8398 125.859 131.926 147.493 74.9734 152" stroke="#000000" fill="none"></path>
          </svg>
    `
  },
  {
    title: 'Lamar Pekerjaan dengan Klik',
    description: 'Temukan dan lamar pekerjaan yang sesuai dengan keahlian Anda hanya dengan sekali klik.',
    svg: `
      <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 172 172" fill="none" class="w-28 h-28 min-[576px]:h-48 min-[576px]:w-40">
        <circle cx="86" cy="86" r="86" fill="rgb(197, 138, 255)"></circle>
        <path fill="rgb(211, 251, 82)" d="m62 53.1 78.8 48.6a101 101 0 0 1-15.5 12.8 76.9 76.9 0 0 1 28.7 27l-31 28.8-20.6-35.7L87.7 149 62 53Z"></path>
        <path stroke="#000000" stroke-linejoin="bevel" d="M140.8 101.7 62 53.1 87.7 149l14.7-14.4 20.7 35.7 30.9-28.8c-4.3-8.6-26.9-33.6-46.8-30.8-19.6 2.8-17.5 10.9-4 10.6 13.6-.2 23.8-6.3 37.6-19.6Z" fill="none"></path>
        <path stroke="#000000" d="M58.5 40c-4-3.7-6.5-14-4.8-38C47.5 33.5 34 32 16 23c23 15.1 16 31-1 39.5 32-8 38.7 2 38.7 7.8M68.5 41l11-37.5" fill="none"></path>
        <path stroke="#000000" stroke-linejoin="bevel" d="m76.2 51.7 15.7-1.2m17.3-1.2-13.7 1" fill="none"></path>
      </svg>
    `
  }
];

</script>

<div class="py-24 text-center w-full overflow-hidden">
  <div class="pb-20 px-5 max-w-[90rem] m-auto min-[1440px]:pl-10 min-[1440px]:pr-10 md:pb-0">
    <h1 class="m-auto">Mulai Karir Anda <br>dengan Langkah Mudah</h1>
    <ul class="flex-col justify-between flex list-none w-full max-w-[85.13rem] mt-9 mx-auto gap-20 min-[992px]:mt-16 min-[992px]:flex-row min-[992px]:justify-evenly">
      {#each items as item}
        <li class="list-item">
          <div class="items-center flex-col justify-center flex gap-4 md:justify-start">
            {@html item.svg} <!-- Safely insert the SVG content -->
            <h2 class="text-4xl font-semibold">{item.title}</h2>
            <p class="text-lg">{item.description}</p>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</div>
