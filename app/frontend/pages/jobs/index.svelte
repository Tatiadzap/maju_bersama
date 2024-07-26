<script lang="ts">

  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";

  export let jobs;
  // Log the jobs array to check its structure
  // console.log('Jobs:', jobs[0].employer.user.profile_picture);
</script>

<!-- {#each jobs as job}
  <p>{job.title}</p>
  <p>{job.employer.company_name}</p>
  <p>{job.employer.user.profile_picture}</p>
{/each} -->
