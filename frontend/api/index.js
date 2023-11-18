// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { TwitterAuthProvider, getAuth, getRedirectResult, GithubAuthProvider, signInWithPopup } from "firebase/auth";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
// very secret
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const providerTwitter = new TwitterAuthProvider();
const providerGithub = new GithubAuthProvider();
const auth = getAuth();
var provider = new firebase.auth.TwitterAuthProvider();

function twitterSignin() {
   firebase.auth().signInWithPopup(provider)
    
  .then(function(result) {
      var token = result.credential.accessToken;
      var user = result.user;
		
      console.log(token)
      console.log(user)
   }).catch(function(error) {
      console.log(error.code)
      console.log(error.message)
   });
}

function twitterSignout() {
   firebase.auth().signOut()
   
   .then(function() {
      console.log('Signout successful!')
   }, function(error) {
      console.log('Signout failed!')
   });
}
