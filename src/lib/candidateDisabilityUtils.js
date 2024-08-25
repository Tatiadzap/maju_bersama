import axios from "axios";

// Function to save or update a candidate's disability
export async function saveOrUpdateCandidateDisability(
  candidateId,
  candidateDisability,
  form
) {
  try {
    let response;

    // Remove id when creating a new candidate disability
    const { id, ...disabilityData } = candidateDisability;

    if (!id) {
      // Create new candidate disability in the backend
      response = await axios.post(
        `/candidates/${candidateId}/candidate_disabilities`,
        { candidate_disability: disabilityData } // Send only necessary data
      );
      // Add the newly created candidate disability to the form data
      form.candidate_disabilities = [
        ...form.candidate_disabilities,
        { ...response.data },
      ];
    } else {
      // Update existing candidate disability in the backend
      response = await axios.put(
        `/candidates/${candidateId}/candidate_disabilities/${id}`,
        { candidate_disability: disabilityData } // Send only necessary data
      );
      // Update the existing candidate disability in the form data
      form.candidate_disabilities = form.candidate_disabilities.map((cd) =>
        cd.id === id ? { ...response.data } : cd
      );
    }
    return { success: true };
  } catch (error) {
    console.error(
      "Failed to save or update disability:",
      error.response || error.message
    );
    console.error("Request data:", candidateDisability); // Correct reference to the sent data
    return { success: false, error: error.message };
  }
}

// Function to initialize a new candidate disability
export function initializeNewCandidateDisability(availableDisabilities) {
  return {
    id: null,
    disability_id: availableDisabilities.length
      ? availableDisabilities[0].id
      : "",
    details: "",
  };
}

// Function to prepare an existing disability for editing
export function prepareCandidateDisabilityForEdit(disability) {
  return { ...disability };
}
