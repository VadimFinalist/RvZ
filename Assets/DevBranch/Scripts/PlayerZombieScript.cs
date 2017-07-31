using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
  public class PlayerZombieScript : PlayerGeneralScript
  {
    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
      playerName = "PlayerZombie";

      teamTag = "TeamZombie";
      headTag = "ZombieHead";

      photonView.RPC("SetTags", PhotonTargets.All, new object[] { teamTag, headTag });
      photonView.RPC("SetName", PhotonTargets.All, playerName + " ");

      SetHUD();
    }
  }
}
