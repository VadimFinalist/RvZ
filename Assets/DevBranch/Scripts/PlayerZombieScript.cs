using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public class PlayerZombieScript : PlayerGeneralScript
    {
        // Use this for initialization
        void Start()
        {
            playerName = "PlayerZombie";

            teamTag = "TeamZombie";
            headTag = "ZombieHead";

            photonView.RPC("SetTags", PhotonTargets.All, new object[] { teamTag, headTag });
            photonView.RPC("SetName", PhotonTargets.All, playerName + " ");

            //SetHUD();
        }
    }
}
