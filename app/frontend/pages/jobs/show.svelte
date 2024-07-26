<script>
  import { Separator } from "$lib/components/ui/separator";

  export let job
  export let employer
  export let company_details

  console.log(company_details)
  // export let company_details
</script>


<div class="flex py-12">
  <div class="flex space-x-4">
    <img src="{company_details.profile_picture}" alt="" class="w-24 h-24">
    <div class="flex flex-col justify-center">
      <p class="text-xl font-medium">{job.title}</p>
      <div class="flex space-x-6 row">
        <p>{employer.company_name}</p>
        <p>{job.location}</p>
        <p>Full-time</p>
        <p>{job.status}</p>
        <!-- <p>{job.updated_at}</p> -->

      </div>
    </div>
  </div>
</div>

<div class="w-full h-0.5 bg-gray-200"></div>
<div class="flex my-12">
  <div class="space-y-12 flex-basis-2/3">
    <div>
      <h2 class="mb-2 text-lg font-medium">About the role</h2>
      <p>{job.description}</p>
    </div>

    <div>
      <h2 class="mb-2 text-lg font-medium">Job requirements</h2>
      <p>{job.requirements}</p>
    </div>
  </div>
</div>
<!-- {company_details} -->
