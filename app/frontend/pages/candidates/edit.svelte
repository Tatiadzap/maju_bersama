<script lang="ts">
  import { Button } from "$lib/components/ui/button";
  import * as Card from "$lib/components/ui/card"
  import { Input } from "$lib/components/ui/input";
  import { Label } from "$lib/components/ui/label";
  import { Textarea } from "$lib/components/ui/textarea";
  import { useForm } from "@inertiajs/svelte";
  import axios from 'axios';

  export let candidate = null;
  export let user = null;
  export let experiences = [];

  let form = useForm({
    candidate: {
      first_name: candidate?.first_name || '',
      last_name: candidate?.last_name || '',
      date_of_birth: candidate?.date_of_birth || '',
      languages: candidate?.languages || [],
    },
    user: {
      phone: user?.phone || '',
      address: user?.address || '',
      city: user?.city || '',
      state: user?.state || '',
      zip_code: user?.zip_code || '',
      country: user?.country || '',
      bio: user?.bio || '',
    },
    experiences: experiences || [],  // Adding experiences array
  });

  let currentStep = 0;
  let editingExperience = null;
  let showForm = false;

  const steps = [
    {
      href: '#personal-info',
      title: 'Personal Info',
      description: 'Update your personal details.',
    },
    {
      href: '#contact-info',
      title: 'Contact Info',
      description: 'Update your contact details.',
    },
    {
      href: '#additional-info',
      title: 'Additional Info',
      description: 'Provide additional information about yourself.',
    },
    {
      href: '#experiences',
      title: 'Experiences',
      description: 'Add and update your job experiences.',
    }
  ];

  function handleStepChange(step: number) {
    currentStep = step;
  }

  function goToNextStep() {
    if (currentStep < steps.length - 1) {
      currentStep += 1;
    }
  }

  function goToPreviousStep() {
    if (currentStep > 0) {
      currentStep -= 1;
    }
  }

  function addExperience() {
    showForm = true;
    editingExperience = {
      id: null,
      job_title: '',
      company_name: '',
      start_date: '',
      end_date: '',
      description: '',
    };
  }

  async function saveExperience() {
    try {
      let response;

      if (!editingExperience.id) {
        // Create new experience in the backend
        response = await axios.post(`/candidates/${candidate.id}/experiences`, editingExperience);
        $form.experiences = [...$form.experiences, { ...response.data }];
      } else {
        // Update existing experience in the backend
        response = await axios.put(`/experiences/${editingExperience.id}`, editingExperience);
        $form.experiences = $form.experiences.map(exp => exp.id === editingExperience.id ? { ...response.data } : exp);
      }

      showForm = false;
      editingExperience = null;
    } catch (error) {
      console.error('Failed to save experience:', error);
    }
  }

  function editExperience(experience) {
    editingExperience = { ...experience };
    showForm = true;
  }

  function cancelEdit() {
    showForm = false;
    editingExperience = null;
  }

  function submit() {
    // Log the current experiences array to see what's being submitted
    console.log($form.experiences);

    // Handle form submission using Inertia's form handling
    $form.put(`/candidates/${candidate.id}`, {
      onSuccess: () => {
        console.log('Form submitted successfully');
        // Optionally redirect or show a success message
      },
      onError: (errors) => {
        console.error('Form submission failed', errors);
      }
    });
  }

    // Reactive variables for title and description based on the current step
  $: cardTitle = steps[currentStep].title;
  $: cardDescription = steps[currentStep].description;
</script>


<div class="flex">
  <!-- Sidebar for step navigation -->
  <nav class="w-1/4 pr-4 space-y-2 text-left">
    <ul>
      {#each steps as item, index}
        {@const isActive = currentStep === index}

        <li>
          <a
            href={item.href}
            class={`block w-full p-2 rounded-md ${isActive ? 'bg-black text-white' : 'text-black'}`}
            on:click={() => handleStepChange(index)}
          >
            {item.title}
          </a>
        </li>
      {/each}
    </ul>
  </nav>

  <!-- Main content area for the current step -->
  <div class="w-3/4 p-4">
    <Card.Root>
      <Card.Header>
        <Card.Title>{cardTitle}</Card.Title>
        <Card.Description>{cardDescription}</Card.Description>
      </Card.Header>
      <Card.Content>
        {#if candidate && user}
          <form on:submit|preventDefault={submit}>
            <div class="space-y-4">
              {#if currentStep === 0}
                <!-- Personal Info Step -->
                <div>
                  <Label for="first_name">First Name</Label>
                  <Input id="first_name" bind:value={$form.candidate.first_name} placeholder="First Name" />
                  {#if $form.errors['candidate.first_name']}
                    <div class="text-sm text-red-500">{$form.errors['candidate.first_name']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="last_name">Last Name</Label>
                  <Input id="last_name" bind:value={$form.candidate.last_name} placeholder="Last Name" />
                  {#if $form.errors['candidate.last_name']}
                    <div class="text-sm text-red-500">{$form.errors['candidate.last_name']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="date_of_birth">Date of Birth</Label>
                  <Input id="date_of_birth" type="date" bind:value={$form.candidate.date_of_birth} />
                  {#if $form.errors['candidate.date_of_birth']}
                    <div class="text-sm text-red-500">{$form.errors['candidate.date_of_birth']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="languages">Languages</Label>
                  <Input id="languages" bind:value={$form.candidate.languages} placeholder="Languages (comma separated)" />
                  {#if $form.errors['candidate.languages']}
                    <div class="text-sm text-red-500">{$form.errors['candidate.languages']}</div>
                  {/if}
                </div>
              {:else if currentStep === 1}
                <!-- Contact Info Step -->
                <div>
                  <Label for="phone">Phone</Label>
                  <Input id="phone" bind:value={$form.user.phone} placeholder="Phone" />
                  {#if $form.errors['user.phone']}
                    <div class="text-sm text-red-500">{$form.errors['user.phone']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="address">Address</Label>
                  <Input id="address" bind:value={$form.user.address} placeholder="Address" />
                  {#if $form.errors['user.address']}
                    <div class="text-sm text-red-500">{$form.errors['user.address']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="city">City</Label>
                  <Input id="city" bind:value={$form.user.city} placeholder="City" />
                  {#if $form.errors['user.city']}
                    <div class="text-sm text-red-500">{$form.errors['user.city']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="state">State</Label>
                  <Input id="state" bind:value={$form.user.state} placeholder="State" />
                  {#if $form.errors['user.state']}
                    <div class="text-sm text-red-500">{$form.errors['user.state']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="zip_code">Zip Code</Label>
                  <Input id="zip_code" bind:value={$form.user.zip_code} placeholder="Zip Code" />
                  {#if $form.errors['user.zip_code']}
                    <div class="text-sm text-red-500">{$form.errors['user.zip_code']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="country">Country</Label>
                  <Input id="country" bind:value={$form.user.country} placeholder="Country" />
                  {#if $form.errors['user.country']}
                    <div class="text-sm text-red-500">{$form.errors['user.country']}</div>
                  {/if}
                </div>
              {:else if currentStep === 2}
                <!-- Additional Info Step -->
                <div class="grid gap-3">
                  <Label for="bio">Bio</Label>
                  <Textarea
                    id="bio"
                    bind:value={$form.user.bio}
                    placeholder="Tell us about yourself"
                    class="min-h-32"
                  />
                  {#if $form.errors['user.bio']}
                    <div class="text-sm text-red-500">{$form.errors['user.bio']}</div>
                  {/if}
                </div>
              {:else if currentStep === 3}
              <!-- Experiences Step -->
                <div>
                  <!-- List of existing experiences -->
                  {#each $form.experiences as experience, index (experience.id)}
                    <div class="mb-4 p-4 border rounded-md">
                      <h4>{experience.job_title} at {experience.company_name}</h4>
                      <p>{experience.start_date} to {experience.end_date}</p>
                      <p>{experience.description}</p>
                      <Button type="button" on:click={() => editExperience(experience)}>Edit</Button>
                    </div>
                  {/each}

                  <!-- Add new experience button -->
                  {#if !showForm}
                    <Button type="button" on:click={addExperience}>Add New Experience</Button>
                  {/if}

                  <!-- Experience form -->
                  {#if showForm}
                    <div class="mb-4 p-4 border rounded-md space-y-4">
                      <div>
                        <Label for="job_title">Job Title</Label>
                        <Input id="job_title" bind:value={editingExperience.job_title} placeholder="Job Title" />
                      </div>

                      <div>
                        <Label for="company_name">Company Name</Label>
                        <Input id="company_name" bind:value={editingExperience.company_name} placeholder="Company Name" />
                      </div>

                      <div>
                        <Label for="start_date">Start Date</Label>
                        <Input id="start_date" type="date" bind:value={editingExperience.start_date} />
                      </div>

                      <div>
                        <Label for="end_date">End Date</Label>
                        <Input id="end_date" type="date" bind:value={editingExperience.end_date} />
                      </div>

                      <div>
                        <Label for="description">Description</Label>
                        <Textarea id="description" bind:value={editingExperience.description} placeholder="Job Description" />
                      </div>

                      <div class="flex justify-between">
                        <Button type="button" on:click={saveExperience} color="blue">Save Experience</Button>
                        <Button type="button" on:click={cancelEdit} color="gray">Cancel</Button>
                      </div>
                    </div>
                  {/if}
                </div>
              {/if}
            </div>
            <Card.Footer class="px-0 py-4 border-t">
              <div class="flex justify-between">
                {#if currentStep > 0}
                  <Button type="button" on:click={goToPreviousStep}>Previous</Button>
                {/if}
                {#if currentStep < steps.length - 1}
                  <Button type="button" on:click={goToNextStep}>Next</Button>
                {:else}
                  <Button type="submit" disabled={$form.processing}>Save</Button>
                {/if}
              </div>
            </Card.Footer>
          </form>
        {:else}
          <p>Loading...</p> <!-- Handle case where data is not yet available -->
        {/if}
      </Card.Content>
    </Card.Root>
  </div>
</div>
