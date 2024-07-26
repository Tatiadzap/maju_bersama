<script>
  export let job
  export let employer
  export let company_details

  console.log(company_details)
  // export let company_details
</script>

<img src="{company_details.profile_picture}" alt="">
{job.title}
{employer.company_name}
{job.location}
{job.status}
{job.updated_at}
{job.status}


{job.description}


<!-- {company_details} -->
