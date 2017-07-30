using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using VRTK;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public class PistolBehaviourScript : MonoBehaviour
    {

        private bool isPistolGrabbed;

        // Use this for initialization
        void Start()
        {

        }

        // Update is called once per frame
        //void Update ()
        //   {

        //   }

        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name == "PistolHolster" && !gameObject.GetComponent<VRTK_InteractableObject>().IsGrabbed())
            {
                //gameObject.transform.position = other.gameObject.transform.position;
                //gameObject.transform.rotation = other.gameObject.transform.rotation;
                //gameObject.GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition | RigidbodyConstraints.FreezeRotation;
                //GameObject.Find("Slide").GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition | RigidbodyConstraints.FreezeRotation;

                isPistolGrabbed = false;
            }
            else if (other.gameObject.name == "PistolHolster" && gameObject.GetComponent<VRTK_InteractableObject>().IsGrabbed())
            {
                isPistolGrabbed = true;
            }
        }

        private void OnTriggerStay(Collider other)
        {
            if (other.gameObject.name == "PistolHolster" && isPistolGrabbed && !gameObject.GetComponent<VRTK_InteractableObject>().IsGrabbed())
            {
                gameObject.transform.position = other.gameObject.transform.position;
                gameObject.transform.rotation = other.gameObject.transform.rotation;
                gameObject.GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition | RigidbodyConstraints.FreezeRotation;
                GameObject.Find("Slide").GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition | RigidbodyConstraints.FreezeRotation;

                Debug.Log("Staying!");
            }
        }

        private void OnTriggerExit(Collider other)
        {
            if (other.gameObject.name == "PistolHolster" && gameObject.GetComponent<VRTK_InteractableObject>().IsGrabbed())
            {
                gameObject.GetComponent<Rigidbody>().constraints = RigidbodyConstraints.None;
                GameObject.Find("Slide").GetComponent<Rigidbody>().constraints = RigidbodyConstraints.None;

                Debug.Log("Exited!");
            }
        }

    }
}
