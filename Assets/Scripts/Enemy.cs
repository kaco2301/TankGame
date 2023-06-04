using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public Transform bullet;
    public Transform explosion;

    Transform car;
    Transform turret;
    Transform spPoint;
    Transform fire;
    AudioSource gunSound;

    const float RADAR_DIST = 12f;//탐지거리
    const float FIRE_DIST = 10f;//사정거리

    bool canFire = true;

    // Start is called before the first frame update
    void Start()
    {
        InitGame();
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 delta = car.position - transform.position;
        float dist = delta.magnitude;
        //차와 터렛의 벡터 방향
        // 터렛과 차 사이 벡터의 길이
        if (dist <= RADAR_DIST) 
        {
            //turret.LookAt(car);

            Quaternion rot = Quaternion.LookRotation(delta);
            turret.rotation = Quaternion.Slerp(turret.rotation, rot, 5 * Time.deltaTime);
            //시작회전각~목표각까지 일정시간을 두고 실행 = Quaternion.Slerp
        } 
        // 포탑을 자동차 거리로 회전

        // 사정거리 이내인지 검사
        if (dist <= FIRE_DIST && canFire) 
        {
            StartCoroutine(AutoFire()); 
        }
        if (dist > FIRE_DIST) 
        { 
            gunSound.Stop(); 
        }

    }

    IEnumerator AutoFire()
    {
        Instantiate(bullet, spPoint.position, spPoint.rotation);
        fire.gameObject.SetActive(true);
        gunSound.Play();
        canFire = false;
        yield return new WaitForSeconds(0.2f);
        canFire = true;
    }

    void InitGame()
    {
        car = GameObject.Find("CarBody").transform;
        turret = transform.Find("TurretHead");
        spPoint = transform.Find("TurretHead/Turret/SpPoint");

        fire = transform.Find("TurretHead/Turret/Fire");
        fire.gameObject.SetActive(false);

        gunSound = GetComponent<AudioSource>();

    }
}
