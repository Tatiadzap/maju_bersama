<script lang="ts">
  import dayjs from 'dayjs';
  import { useForm, router } from '@inertiajs/svelte';
  import { createEventDispatcher } from 'svelte';

  export let toggleEditForm;
  export let event;
  export let statuses


  const dispatch = createEventDispatcher();

  // Format the date for the datetime-local input
  let formattedStartDate = event.start_time
    ? dayjs(event.start_time).format('YYYY-MM-DDTHH:mm')
    : '';

  let formattedEndDate = event.end_time
    ? dayjs(event.end_time).format('YYYY-MM-DDTHH:mm')
    : '';


  // Initialize the form with formatted date
  let form = useForm({
    status: event.status,
    name: event.name,
    description: event.description,
    location: event.location,
    start_time: formattedStartDate,
    end_time: formattedEndDate
  });

  async function submit() {
    await $form.put(`/events/${event.id}`, {
      onSuccess: () => {
        $form.reset();
        router.visit('/events');
      }
    });
    dispatch('submitted');
  }

  function cancel() {
    $form.reset();
    if (toggleEditForm) {
      toggleEditForm();
    } else {
      router.visit('/events'); // Hide the form when cancel is clicked
    }
  }
</script>

<div class="max-w-xl p-8 mx-auto mb-24">
  <h1 class="mb-6 text-2xl font-bold">Edit Event</h1>
  <form on:submit|preventDefault={submit}>

    <div class="mb-4">
      <label for="status" class="block mb-4 text-sm font-medium">Status</label>
      <select bind:value={form.status} class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm">
        {#each statuses as option}
          <option value={option}>{option}</option>
        {/each}
      </select>
      {#if $form.errors.status}
        <div class="form-error">{$form.errors.status}</div>
      {/if}
    </div>


    <div class="mb-4">
      <label for="name" class="block mb-2 text-sm font-medium">Title</label>
      <input
        type="text"
        bind:value={$form.name}
        id="name"
        class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm"
      />
      {#if $form.errors.name}
        <div class="form-error">{$form.errors.name}</div>
      {/if}
    </div>

    <div class="mb-4">
      <label for="description" class="block mb-2 text-sm font-medium">Description</label>
      <textarea
        bind:value={$form.description}
        id="description"
        class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm"
      ></textarea>
      {#if $form.errors.description}
        <div class="form-error">{$form.errors.description}</div>
      {/if}
    </div>

    <div class="mb-4">
      <label for="location" class="block mb-2 text-sm font-medium">Location</label>
      <input
        type="text"
        bind:value={$form.location}
        id="location"
        class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm"
      />
      {#if $form.errors.location}
        <div class="form-error">{$form.errors.location}</div>
      {/if}
    </div>

    <div class="mb-4">
      <label for="start_time" class="block mb-2 text-sm font-medium">Start Date</label>
      <input
        type="datetime-local"
        bind:value={$form.start_time}
        id="start_time"
        class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm"
      />
      {#if $form.errors.start_time}
        <div class="form-error">{$form.errors.start_time}</div>
      {/if}
    </div>
    <div class="mb-4">
      <label for="end_time" class="block mb-2 text-sm font-medium">End Date</label>
      <input
        type="datetime-local"
        bind:value={$form.end_time}
        id="start_time"
        class="block w-full p-2 mt-1 border rounded-md shadow-sm focus:ring focus:border sm:text-sm"
      />
      {#if $form.errors.end_time}
        <div class="form-error">{$form.errors.end_time}</div>
      {/if}
    </div>

    <button
      type="submit"
      disabled={$form.processing}
      class="bg-blue-500 text-white py-2 px-4 rounded-md shadow-sm hover:bg-blue-600"
    >
      Submit
    </button>
    <button
      type="button"
      on:click={cancel}
      class="ml-4 bg-gray-500 text-white py-2 px-4 rounded-md shadow-sm hover:bg-gray-600"
    >
      Cancel
    </button>
  </form>
</div>
