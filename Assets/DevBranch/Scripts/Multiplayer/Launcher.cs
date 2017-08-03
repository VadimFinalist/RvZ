using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public class Launcher : Photon.PunBehaviour
    {

        #region Public Variables

        /// <summary>
        /// The PUN loglevel. 
        /// </summary>
        public PhotonLogLevel LogLevel = PhotonLogLevel.Informational;

        [Tooltip("The Ui Panel to let the user enter name, connect and play")]
        public GameObject controlPanel;
        [Tooltip("The UI Label to inform the user that the connection is in progress")]
        public GameObject progressLabel;
        [Tooltip("The UI Dropdown which will select mode")]
        public GameObject modeSelector;
        [Tooltip("The UI Dropdown which will select map")]
        public GameObject mapSelector;
        [Tooltip("The UI GameObject group will be hidden/shown when needed")]
        public GameObject beHidden;

        #endregion

        #region MonoBehaviour CallBacks
        void Start()
        {
            progressLabel.SetActive(false);
            beHidden.SetActive(true);
        }

        #endregion

        #region Public Methods

        public void Connect()
        {
            progressLabel.SetActive(true);
            beHidden.SetActive(false);

            if (mapSelector.GetComponent<Dropdown>().value == 0)
            {
                Debug.Log("We load the 'Down Town' map");
                // #Critical
                //Load the Room Down Town level
                PhotonNetwork.LoadLevel(1);
            }
            else if (mapSelector.GetComponent<Dropdown>().value == 1)
            {
                Debug.Log("We load the 'Old town' map");
                // #Critical
                //Load the Room Old Town level
                PhotonNetwork.LoadLevel(2);
            }
        }

        #endregion
    }
}
