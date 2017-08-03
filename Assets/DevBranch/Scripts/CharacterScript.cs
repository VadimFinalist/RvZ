using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using VRTK;

namespace Com.VadimUnityDev.MP_Test
{
    public class CharacterScript : Photon.PunBehaviour
    {

        public VRTK_ControllerEvents LeftController;
        public VRTK_ControllerEvents RightController;

        // Use this for initialization
        void Start()
        {
            //LeftController.TouchpadPressed += TouchpadPressed;
        }

        // Update is called once per frame
        void Update()
        {
            if (photonView.isMine == false && PhotonNetwork.connected == true)
            {
                return;
            }
        }

        private void TouchpadPressed(object sender, ControllerInteractionEventArgs e)
        {
            if (Time.timeScale > 0)
            {
                Time.timeScale = 0;
            }
            else
            {
                Time.timeScale = 1;
            }
        }


    }
}
