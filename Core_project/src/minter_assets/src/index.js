// The minter is the representation of the minter contract in main.mo but in JavaScript
import { minter } from "../../declarations/minter";

// This is library to use with principal that is provided by Dfinity
import { Principal } from "@dfinity/principal";



// For beginners : This is really basic Javascript code that add an event to the "Mint" button so that the mint_nft function is called when the button is clicked.
const mint_button = document.getElementById("mint");
mint_button.addEventListener("click", mint_nft);

async function mint_nft() {
  
  // Get the url of the image from the input field
  const name = document.getElementById("name").value.toString();
  console.log("The url we are trying to mint is " + name);

  // Get the principal from the input field.
  const principal_string = document.getElementById("principal").value.toString();
  const principal = Principal.fromText(principal_string);

  // Mint the image by calling the mint_principal function of the minter.
  const mintId = await minter.mint_principal(name, principal);
  console.log("The id is " + Number(mintId));
  // Get the id of the minted image.

  // Get the url by asking the minter contract.
  document.getElementById("nft").src = await minter.tokenURI(mintId);

  // Show some information about the minted image.
  document.getElementById("greeting").innerText = "this nft owner is " + principal_string + "\nthis token id is " + Number(mintId);

  const own_button = document.getElementById("check");
  own_button.addEventListener("click",own_nft);
}

async function own_nft() {
  // Get the principal from the input field.
  const principal_string_own = document.getElementById("principal_owned").value.toString();
  const principal_own = Principal.fromText(principal_string_own);

  // Mint the image by calling the mint_principal function of the minter.
  const mint_num = await minter.galleryOf(principal_own);
  console.log("The id is " + Array(mint_num));

  // Show how many nft the person minted.
  document.getElementById("amount").innerText = "You have own " + Array(mint_num);
};